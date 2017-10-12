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
    var speciality: String?
    var experience : String?
    var speakingLang : String?
    var online: Bool?
    var createdAt: Date?
    var isFavourite: Bool?
    
    init?(map: Map) {
        
    }
    
    init() {}
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        name <- map["name"]
        avatar <- map["avatar"]
        introduction <- map["introduction"]
        qualifications <- map["qualifications"]
        speciality <- map["speciality"]
        experience <- map["experience"]
        speakingLang <- map["speaking_lang"]
        online <- map["online"]
        createdAt <- (map["created_at"], DateTransform())
        isFavourite <- map["is_favourite"]
    }
}
