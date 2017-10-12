//
//  User.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/25/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct User: Mappable {

    var name: String?
    var email: String!
    var createdAt: Date?
    var fbid: String?
    var token: String?
    
    init?(map: Map) {
        
    }
    
    init() {}
    
    mutating func mapping(map: Map) {
        name <- map["name"]
        email <- map["email"]
        createdAt <- (map["created_at"], DateTransform())
        fbid <- map["fbid"]
        token <- map["token"]
    }
}
