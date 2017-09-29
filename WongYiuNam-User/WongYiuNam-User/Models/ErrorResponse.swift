//
//  ErrorResponse.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/29/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct ErrorResponse: Mappable {
    
    var msg: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        msg <- map["msg"]
    }
}
