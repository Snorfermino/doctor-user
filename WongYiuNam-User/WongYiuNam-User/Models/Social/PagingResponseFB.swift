//
//  PagingResponseFB.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/5/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct PagingResponseFB<T: BaseMappable>: Mappable {
    
    var data: [T]!
    var nextPage: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data <- map["data"]
        nextPage <- map["paging.cursors.after"]
    }
}
