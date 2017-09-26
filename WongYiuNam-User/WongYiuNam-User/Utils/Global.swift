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
    
    static var userInfo: User?
    static var user: User? {
        set {
            userInfo = newValue
            NotificationCenter.default.post(name: Notification.Name("UserLoginedNotification"), object: nil)
            DataManager.saveUserInfo(user: newValue)
        }
        get {
            return userInfo
        }
    }
}
