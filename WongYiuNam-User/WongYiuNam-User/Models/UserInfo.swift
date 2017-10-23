//
//  UserInfo.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct UserInfo: Mappable {
    
    public var userId : Int?
    public var name : String?
    public var avatar : String?
    public var dob : String?
    public var postalCode : String?
    public var contactNumber : String?
    public var deliverAddress : String?
    public var invitationCode : String?
    public var createdAt : String?
    public var updatedAt : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userId <- map["user_id"]
        name <- map["name"]
        avatar <- map["avatar"]
        dob <- map["dob"]
        postalCode <- map["postal_code"]
        contactNumber <- map["contact_number"]
        deliverAddress <- map["deliver_address"]
        invitationCode <- map["invitation_code"]
        createdAt <- map["created_at"]
        updatedAt <- map["updated_at"]
    }
}
