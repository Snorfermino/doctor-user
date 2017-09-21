//
//  SignInViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import FacebookLogin
class SignInViewController: UIViewController {
    

    @IBOutlet weak var btnFBLogin: UIButton!
    @IBOutlet weak var viewBtnFBLogin: LoginButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewBtnFBLogin = LoginButton(readPermissions: [ .publicProfile ])
        // Handle clicks on the button
        btnFBLogin.addTarget(self, action: #selector(self.loginButtonClicked), for: .touchUpInside)
//        viewBtnFBLogin.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
}
