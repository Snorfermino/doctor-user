//
//  PagingResponseYT.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/5/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct PagingResponseYT<T: BaseMappable>: Mappable {
    
    var data: [T]!
    var nextPageToken: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        data <- map["items"]
        nextPageToken <- map["nextPageToken"]
    }
}

