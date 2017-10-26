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
    static let userInfoKey = "loggedIn"
    private let appToken = "Ly93b25neWl1bmFtLXBocC5oZXJva3VhcHAuY29tL2FwaS9hdXRoL2xvZ2luIiwiaWF"
    private let userDefault = UserDefaults.standard
    var userInfo: WYNLogedInUserInfo {
        get {
            let json = userDefault.value(forKey: UserLoginInfo.userInfoKey)
            var objectData = WYNLogedInUserInfo()
            objectData = Mapper<WYNLogedInUserInfo>().map(JSONObject: json, toObject: objectData)
            return objectData
        }
        set { userDefault.set(newValue, forKey: UserLoginInfo.userInfoKey) }
    }
    var isLoggedIn: Bool {
        get {
            return UserDefaults.standard.object(forKey: UserLoginInfo.userInfoKey) != nil
        }
    }
    func getAppToken() -> String{
        return appToken
    }
}
