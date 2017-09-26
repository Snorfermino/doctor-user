//
//  Global.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/8/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation

class Global {
    static var logined: Bool = false
    static var user: User? {
        set {
            DataManager.saveUserInfo(user: newValue)
        }
        get {
            return self.user
        }
    }
}
