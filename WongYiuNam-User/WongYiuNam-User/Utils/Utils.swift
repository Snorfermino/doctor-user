//
//  Utils.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import KRProgressHUD

class Utils {
    
    public static func showHub(view : UIView) {
        KRProgressHUD.show(withMessage: "Please wait...")
    }
    
    public static func hideHub(view : UIView) {
        KRProgressHUD.dismiss()
    }
    
    public static func showAlert(title: String?, message: String?, viewController: UIViewController) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        viewController.present(alertController, animated: true, completion: nil)
    }
}
