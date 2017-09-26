//
//  BaseViewController.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/19/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewWillAppear(_ animated: Bool) {
        if let cnt = navigationController?.viewControllers.count {
            if(cnt > 1) {
                setNavigationBarItemForBack()
            }
        }
    }
}
