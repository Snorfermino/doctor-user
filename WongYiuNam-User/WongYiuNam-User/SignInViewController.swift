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

class SignInViewController: UIViewController {
    
    @IBOutlet weak var btnFBLogin: UIButton!
    @IBOutlet weak var emailAddressTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnFBLogin.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
        emailAddressTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile, .email ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
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
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        let email = "admin@admin.com"
        let password = "54321"
        Utils.showHub(view: view)
        let completion = {(user: User?, error: String?) -> Void in
            Utils.hideHub(view: self.view)
            if let user = user {
                Global.user = user
            } else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
            }
        }
        ApiManager.login(email: email, password: password, completion: completion)
    }
}
