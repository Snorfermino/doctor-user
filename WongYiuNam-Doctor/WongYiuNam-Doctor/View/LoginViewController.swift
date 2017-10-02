//
//  LoginViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
    
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel(self)
        
    }
    
    override func setupView() {
        super.setupView()
        navBar.isHidden = true
        showIndicator()
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
        //Use for flow test only
                performSegue(withIdentifier: "ProfileVC", sender: nil)
        showIndicator()
//        viewModel.login(tfEmail.text!,tfPassword.text!)
    }
    
}
extension LoginViewController: LoginViewModelDelegate{
    func loginSuccess() {
        performSegue(withIdentifier: "ProfileVC", sender: nil)
    }
    func loginFailed() {
        alert(title: "Login Failed", message: "Invalid username or password")
    }
}
