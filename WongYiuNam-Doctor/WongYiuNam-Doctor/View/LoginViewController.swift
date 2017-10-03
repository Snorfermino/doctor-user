//
//  LoginViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import SVProgressHUD
class LoginViewController: BaseViewController {
    
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        viewModel = LoginViewModel(self)
        setupView()
    }
    
    override func setupView() {
        super.setupView()
        navBar.isHidden = true
        showIndicator()
        checkLogin()
        UITextField.connectFields(fields: [tfEmail, tfPassword])
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
    // TODO: show progress hud when calling api
    @IBAction func btnSignInPressed(_ sender: UIButton){
        SVProgressHUD.show()
        viewModel.login(tfEmail.text!,tfPassword.text!)
    }
    
}
extension LoginViewController: LoginViewModelDelegate{
    func loginSuccess() {
        DispatchQueue.global(qos: .default).async {
            // Background thread
            DispatchQueue.main.async(execute: {
                SVProgressHUD.dismiss()
            })
        }

        performSegue(withIdentifier: "ProfileVC", sender: nil)
    }
    
    func loginFailed() {
        DispatchQueue.global(qos: .default).async {
            // Background thread
            DispatchQueue.main.async(execute: {
                SVProgressHUD.dismiss()
            })
        }
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
