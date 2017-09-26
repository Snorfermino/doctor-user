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
        userDefaults.set(user.toJSON(), forKey: "userInfo")
        userDefaults.synchronize()
    }
    
    static func getUserInfo() -> User? {
        let userJson = UserDefaults.standard.object(forKey: "userInfo") as? [String: Any]
        if let userJson = userJson {
            return User(JSON: userJson)
        } else {
            return nil
        }
    }
}
