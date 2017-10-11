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
    
    func alert(title: String?, message: String?,
               isCancelable: Bool = false,
               handler: ((UIAlertAction) -> Swift.Void)? = nil) {
        
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        let action = UIAlertAction(title: "Ok", style: .default, handler: handler)
        alertVC.addAction(action)
        
        if isCancelable {
            let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: handler)
            alertVC.addAction(cancel)
        }
        self.present(alertVC, animated: true, completion: nil)
    }
}
