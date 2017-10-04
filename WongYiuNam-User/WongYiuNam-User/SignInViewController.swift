//
//  SignInViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import FacebookLogin
import PopupDialog
import FacebookCore
import RxCocoa
import RxSwift

class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnFBLogin: UIButton!
    @IBOutlet weak var emailAddressTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindUI()
        setUpUI()
    }
    
    func bindUI() {
        btnFBLogin.rx.tap
            .subscribe(onNext: { [unowned self] in
                self.loginButtonClicked()
            })
            .disposed(by: disposeBag)
    }
    
    func setUpUI() {
        emailAddressTextField.borderStyle = .none
        emailAddressTextField.delegate = self
        passwordTextField.borderStyle = .none
        passwordTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
        navigationItem.rightBarButtonItem = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    // Once the button is clicked, show the login dialog
    func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let _, let _, let accessToken):
                print("Logged in!")
                let completion = {(userInfo: [String: Any]?, error: Error?) -> Void in
                    print(userInfo)
                }
                self.getUserInfo(accessToken: accessToken, completion: completion)
            }
        }
    }
    
    func getUserInfo(accessToken: AccessToken, completion: @escaping (_ : [String: Any]?, _ : Error?) -> Void) {
        let request = GraphRequest(graphPath: "me", parameters: ["fields": "name, id, email"])
        request.start { response, result in
            switch result {
            case .failed(let error):
                completion(nil, error)
            case .success(let graphResponse):
                completion(graphResponse.dictionaryValue, nil)
            }
        }
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
        let fotgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        let popup = PopupDialog(viewController: fotgotPasswordVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        present(popup, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonClicked() {
        Utils.showHub(view: view)
        let completion = {(user: User?, error: String?) -> Void in
            Utils.hideHub(view: self.view)
            if let user = user {
                Global.user = user
            } else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
            }
        }
        ApiManager.login(email: emailAddressTextField.text!, password: passwordTextField.text!, completion: completion)
    }
}

extension SignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailAddressTextField {
            passwordTextField.becomeFirstResponder()
        } else if textField == passwordTextField {
            textField.resignFirstResponder()
            signInButtonClicked()
        }
        return true
    }
}
