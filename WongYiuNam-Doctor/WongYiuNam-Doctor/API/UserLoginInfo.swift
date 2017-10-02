//
//  Alamofire.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import ObjectMapper
class UserLoginInfo {
    static let shared =  UserLoginInfo()
    private let userDefault = UserDefaults.standard
    var userInfo: WYNLogedInUserInfo {
        get {
            let loginInfo = userDefault.value(forKey: "loggedIn") as! WYNLogedInUserInfo
            
            return loginInfo
        }
        set { userDefault.set(newValue, forKey: "loggedIn") }
        
    }
    
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.object(forKey: "loggedIn") != nil
        }
    }
}

