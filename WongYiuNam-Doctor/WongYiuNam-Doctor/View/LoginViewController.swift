//
//  LoginViewController.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/15/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfEmail:UITextField!
    @IBOutlet weak var tfPassword:UITextField!
    var viewModel: LoginViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel(self)
    }
    // TODO: show progress hud when calling api
    @IBAction func btnSignInPressed(_ sender: UIButton){
        performSegue(withIdentifier: "ProfileVC", sender: nil)
        viewModel.login(tfEmail.text!,tfPassword.text!)
    }

}
extension LoginViewController: LoginViewModelDelegate{
    func loginSuccess() {
        print("Login success")
    }
}
