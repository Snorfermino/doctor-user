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
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        token <- map["token"]
        id <- map["id"]
        name <- map["name"]
        email <- map["email"]
        doctor <- map["doctor"]
        createdAt <- map["created_at"]
    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        id = aDecoder.decodeObject(forKey: "id") as? Int
//        name = aDecoder.decodeObject(forKey: "name") as? String
//        email = aDecoder.decodeObject(forKey: "email") as? String
//        token = aDecoder.decodeObject(forKey: "token") as? String
//        createdAt = aDecoder.decodeObject(forKey: "createdAt") as? Int
//    }
//    
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(id, forKey: "id")
//        aCoder.encode(name, forKey: "name")
//        aCoder.encode(email, forKey: "email")
//        aCoder.encode(token, forKey: "token")
//        aCoder.encode(createdAt, forKey: "createdAt")
//    }
}
