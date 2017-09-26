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
}
