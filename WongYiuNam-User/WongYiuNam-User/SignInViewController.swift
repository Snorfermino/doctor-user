//
//  SignInViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import PopupDialog

class SignInViewController: UIViewController {
    @IBOutlet weak var emailAddressTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
        
        let fotgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        let popup = PopupDialog(viewController: fotgotPasswordVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        
        present(popup, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        let email = "haag.kirsten@gmail.com"
        let password = "12345"
        let completion = {(user: User?) -> Void in
            print(user)
        }
        ApiManager.login(email: email, password: password, completion: completion)
    }
}
