//
//  LoginViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SVProgressHUD
import JVFloatLabeledTextField
import SkyFloatingLabelTextField
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var tfEmail:SkyFloatingLabelTextField!
    @IBOutlet weak var tfPassword:SkyFloatingLabelTextField!
    var viewModel: LoginViewModel!
    var strEmail = ""
    var strPassword = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewModel = LoginViewModel(self)
        print("Device UUID: " + UIDevice.current.identifierForVendor!.uuidString)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        navBar.isHidden = true
        tfPassword.isSecureTextEntry = true
        tfEmail.delegate = self
        
        tfPassword.delegate = self
        
        showIndicator()
        checkLogin()
        UITextField.connectFields(fields: [tfEmail, tfPassword])
    }
    
    func addShadow(demoview: UIView, blur: Float = 0, spread: Float = 0){
        demoview.layer.cornerRadius = 5
        demoview.layer.shadowColor = UIColor.black.cgColor
        demoview.layer.shadowOffset = CGSize(width: 0.1, height: 2)  //Here you control spread, x and y
        demoview.layer.shadowOpacity = 0.2
        demoview.layer.shadowRadius = 4 //Here your control your blur
        demoview.layer.masksToBounds =  false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hideIndicator()
    }
    
    func checkLogin(){
        if UserLoginInfo.shared.isLoggedIn {
            performSegue(withIdentifier: "ProfileVC", sender: nil)
        } else {
            hideIndicator()
            
        }
    }
    
    @IBAction func btnSignInPressed(_ sender: UIButton){
        SVProgressHUD.show()
        viewModel.login(strEmail,strPassword)
    }
    
}
extension LoginViewController: LoginViewModelDelegate{
    func loginSuccess() {
        SVProgressHUD.dismiss()
        performSegue(withIdentifier: "ProfileVC", sender: nil)
    }
    
    func loginFailed() {
        SVProgressHUD.dismiss()
        alert(title: "Login Failed", message: "Invalid username or password")
    }
}

extension LoginViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}   
extension LoginViewController:UITextFieldDelegate {

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if let field = textField as? SkyFloatingLabelTextField {
            field.text = " "
        }
        return true
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if let field = textField as? SkyFloatingLabelTextField {
//            field.text = ""
//        }
//    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        if let field = textField as? SkyFloatingLabelTextField {
            field.text = " "
        }
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let field = textField as? SkyFloatingLabelTextField {
//            if field.text == " " {
//                field.text = " "
//            } else {
            if (textField.text?.length)! > 1 {
                let range:Range = 1..<(field.text?.length)!
                if field.tag == 1 {
                    strPassword = field.text!.substring(0..<(field.text?.length)!)
                } else {
                    strEmail = field.text!.substring(range)
                }
                print("\(strEmail)===\(strPassword)")
            }
        }
    }
}
