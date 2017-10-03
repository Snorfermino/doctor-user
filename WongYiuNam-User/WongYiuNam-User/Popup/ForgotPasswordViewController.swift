//
//  ForgotPasswordViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/22/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailAddressTextField: DesignableTextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        emailAddressTextField.borderStyle = .none
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
