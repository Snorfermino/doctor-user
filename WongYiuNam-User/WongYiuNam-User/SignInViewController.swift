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
    
    func addFacebookLoginButton(){
        let loginButton = LoginButton(readPermissions: [ .publicProfile ])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
    }
    
    // Once the button is clicked, show the login dialog
    @objc func loginButtonClicked() {
        let loginManager = LoginManager()
        loginManager.logIn([ .publicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .failed(let error):
                print(error)
            case .cancelled:
                print("User cancelled login.")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
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
        let password = "12345"
        let completion = {(user: User?) -> Void in
            Global.user = user
        }
        ApiManager.login(email: email, password: password, completion: completion)
    }
}
