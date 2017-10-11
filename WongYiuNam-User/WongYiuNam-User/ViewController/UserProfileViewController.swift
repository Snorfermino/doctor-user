//
//  UserProfileViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/10/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class UserProfileViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    func loadData() {
        let completion = {(user: User?, error: String?) -> Void in
            if let user = user {
                self.nameTextField.text = user.name
            } else {
                Utils.showAlert(title: "Error !!!", message: error, viewController: self)
            }
        }
        ApiManager.getUserProfile(completion: completion)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setNavigationBarItem()
    }
}
