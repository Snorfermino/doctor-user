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
    @IBOutlet weak var userAgreementCheckBox: CheckBoxButton!
    @IBOutlet weak var privacyPolicyCheckBox: CheckBoxButton!
    @IBOutlet weak var userAgreementLabel: UILabel!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    
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
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let userAgreementViewController = storyboard.instantiateViewController(withIdentifier: "UserAgreementViewController") as! UserAgreementViewController
        userAgreementViewController.navFromRegister = true
        navigationController?.pushViewController(userAgreementViewController, animated: true)
    }
    
    @IBAction func privacyPolicyButtonClicked(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let privacyPolicyViewController = storyboard.instantiateViewController(withIdentifier: "PrivacyPolicyViewController") as! PrivacyPolicyViewController
        privacyPolicyViewController.navFromRegister = true
        navigationController?.pushViewController(privacyPolicyViewController, animated: true)
    }
    
    @IBAction func registerNowButtonClicked(_ sender: Any) {
        let name = fullNameTextField.text!
        let password = passwordTextField.text!
        let confirmPassword = confirmPasswordTextField.text!
        let email = emailAddressTextField.text!
        if(name == "" || password.count < 6 || confirmPassword.count < 6
            || password != confirmPassword || isValidEmail(testStr: email) == false) {
            Utils.showAlert(title: "Error !!!", message: "The input is invalid", viewController: self)
            return
        }
        if(userAgreementCheckBox.isChecked == false){
            Utils.showAlert(title: "Warning !!!", message: "Please read and accept user agreement", viewController: self)
            return
        }
        if(privacyPolicyCheckBox.isChecked == false){
            Utils.showAlert(title: "Warning !!!", message: "Please read and accept privacy policy", viewController: self)
            return
        }
        let completion = {(user: User?, error: String?) -> Void in
            if let user = user {
                Global.user = user
                //NotificationCenter.default.post(name: NSNotification.Name("UserLoginedNotification"), object: nil)
            } else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
            }
        }
        ApiManager.register(name: name, email: email, password: password, completion: completion)
    }
    
    func isValidEmail(testStr: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
}
