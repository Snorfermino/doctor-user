//
//  DataManager.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/25/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation

class DataManager {
    
    static func saveUserInfo(user: User) {
        let userDefaults = UserDefaults.standard
        userDefaults.set(user, forKey: "userinfo")
        userDefaults.synchronize()
    }
    
    static func getUserInfo() -> User? {
        let user = UserDefaults.standard.object(forKey: "userinfo") as? User
        return user
    }
}
