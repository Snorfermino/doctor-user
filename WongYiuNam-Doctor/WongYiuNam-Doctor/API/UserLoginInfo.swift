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
    
    // TODO: move key 'loggedIn' to static let, or fileprivate let, because it is used oftenly and mistyping will make the app not working
    static let shared =  UserLoginInfo()
    private let userDefault = UserDefaults.standard
    var userInfo: WYNLogedInUserInfo {
        
        get {
            let json = userDefault.value(forKey: "loggedIn")
            var objectData = WYNLogedInUserInfo()
            objectData = Mapper<WYNLogedInUserInfo>().map(JSONObject: json, toObject: objectData)
            return objectData
        }
        
        set { userDefault.set(newValue, forKey: "loggedIn") }
        
    }
    
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.object(forKey: "loggedIn") != nil
        }
    }
}

