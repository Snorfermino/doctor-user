//
//  UserInfoFB.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/4/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct UserInfoFB: Mappable {
    
    var id: String?
    var name: String?
    var email: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
    }
}

