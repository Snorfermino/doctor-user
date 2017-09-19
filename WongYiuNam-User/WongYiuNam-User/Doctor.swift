//
//  Doctor.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct Doctor: Mappable {
    
    var id: Int?
    var name: String?
    var avatar: String?
    var introduction: String?
    var qualifications: String?
    var specialty: String?
    var online: Bool?
    var createdAt: Int?
    
    init?(map: Map){
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        introduction <- map["introduction"]
        qualifications <- map["qualifications"]
        specialty <- map["specialty"]
        online <- map["online"]
        createdAt <- map["created_at"]
    }
}
