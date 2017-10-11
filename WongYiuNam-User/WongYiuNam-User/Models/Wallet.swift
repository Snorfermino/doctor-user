//
//  Wallet.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct Wallet: Mappable {
    
    public var userId : Int?
    public var rebateBalance : Int?
    public var creditBalance : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userId <- map["user_id"]
        rebateBalance <- map["rebate_balance"]
        creditBalance <- map["credit_balance"]
    }
}
