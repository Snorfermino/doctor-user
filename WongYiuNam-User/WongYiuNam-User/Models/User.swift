//
//  User.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/25/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct User: Mappable {

    
    var email: String!
    var createdAt: Date?
    var info: UserInfo?
    var wallet: Wallet?
    var token: String?
    
    init?(map: Map) {
        
    }
    
    init() {}
    
    mutating func mapping(map: Map) {
        email <- map["name"]
        createdAt <- (map["created_at"], DateTransform())
        info <- map["info"]
        wallet <- map["wallet"]
        token <- map["token"]
    }
}
