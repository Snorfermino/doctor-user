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

    @IBAction func btnSignInPressed(_ sender: UIButton){
        print("email: \(tfEmail.text!), password: \(tfPassword.text!)" )
        apiProvider.request(.login(email: tfEmail.text!,passwd: tfPassword.text!)) { (result) in
            switch result {
            case let .success(response):
                print(response)
            case .failure:
                print("failed")
            }

        }
    
    }

}
