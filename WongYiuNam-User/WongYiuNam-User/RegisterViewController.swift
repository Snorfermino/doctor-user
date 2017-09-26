//
//  RegisterViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/13/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import PopupDialog

class RegisterViewController: BaseViewController {
    @IBOutlet weak var usernameTextField: DesignableTextField!
    @IBOutlet weak var fullNameTextField: DesignableTextField!
    @IBOutlet weak var contactNumberTextField: DesignableTextField!
    @IBOutlet weak var emailAddressTextField: DesignableTextField!
    @IBOutlet weak var passwordTextField: DesignableTextField!
    @IBOutlet weak var confirmPasswordTextField: DesignableTextField!
    @IBOutlet weak var invitationCodeTextField: DesignableTextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }

    func initUI() {
        usernameTextField.borderStyle = .none
        fullNameTextField.borderStyle = .none
        contactNumberTextField.borderStyle = .none
        emailAddressTextField.borderStyle = .none
        passwordTextField.borderStyle = .none
        confirmPasswordTextField.borderStyle = .none
        invitationCodeTextField.borderStyle = .none
    }
    
    @IBAction func forgotPasswordButtonClicked(_ sender: Any) {
        let fotgotPasswordVC = ForgotPasswordViewController(nibName: "ForgotPasswordViewController", bundle: nil)
        let popup = PopupDialog(viewController: fotgotPasswordVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        present(popup, animated: true, completion: nil)
    }
    
    @IBAction func signInButtonClicked(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func userAgreement(_ sender: Any) {
        
    }
    
    @IBAction func privacyPolicyButtonClicked(_ sender: Any) {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
