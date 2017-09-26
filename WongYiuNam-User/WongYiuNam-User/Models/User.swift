//
//  User.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/25/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct User: Mappable {
    
    var id: Int?
    var name: String?
    var email: String?
    var doctor: Doctor?
    var createdAt: Int?
    var token: String?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        doctor <- map["doctor"]
        createdAt <- map["created_at"]
    }
}
