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
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var tfEmail:JVFloatLabeledTextField!
    @IBOutlet weak var tfPassword:JVFloatLabeledTextField!
    var viewModel: LoginViewModel!
    
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
        tfEmail.animateEvenIfNotFirstResponder = true
        tfEmail.floatingLabelFont = UIFont(name: "Montserrat-SemiBold", size: 12)
        tfEmail.delegate = self
        tfPassword.animateEvenIfNotFirstResponder = true
        tfPassword.floatingLabelFont = UIFont(name: "Montserrat-SemiBold", size: 12)
        tfPassword.delegate = self
        addShadow(demoview: tfEmail)
        addShadow(demoview: tfPassword)
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
        viewModel.login(tfEmail.text!,tfPassword.text!)
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
        if let tf = textField as? JVFloatLabeledTextField {
            tf.alwaysShowFloatingLabel = true
        }

        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let tf = textField as? JVFloatLabeledTextField {
            tf.alwaysShowFloatingLabel = false
        }
    }
}
