//
//  Utils.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/26/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import UIKit
import KRProgressHUD
import PopupDialog

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
    
    public static func requireLogin(viewController: UIViewController) {
        let requireLoginViewController = RequireLoginViewController(nibName: "RequireLoginViewController", bundle: nil)
        let popup = PopupDialog(viewController: requireLoginViewController, buttonAlignment: .horizontal, transitionStyle: .bounceDown, gestureDismissal: true)
        let cancelButton = CancelButton(title: NSLocalizedString("Cancel", comment: ""), height: 40) { }
        let loginButton = DefaultButton(title: NSLocalizedString("Login", comment: ""), height: 40) {
            let loginStoryboard = UIStoryboard.init(name: "Login", bundle: nil)
            let signInViewController = loginStoryboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            viewController.navigationController?.pushViewController(signInViewController, animated: true)
        }
        popup.addButtons([cancelButton, loginButton])
        viewController.present(popup, animated: true, completion: nil)
    }
}
