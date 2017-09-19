//
//  PagingResponse.swift
//  WongYiuNam-User
//
//  Created by Phat Chiem on 9/19/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct PagingResponse<T>: Mappable {
    
    var currentPage = 0
    var data: [T]!
    var from = 0
    var to = 0
    var lastPage = 0
    var perPage = 15
    var total = 0
    var nextPageURL: URL?
    var prevPageURL: URL?
    var path: URL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        currentPage <- map["current_page"]
        data <- map["data"]
        from <- map["from"]
        to <- map["to"]
        lastPage <- map["last_page"]
        perPage <- map["per_page"]
        total <- map["total"]
        nextPageURL <- (map["next_page_url"], URLTransform())
        prevPageURL <- (map["prev_page_url"], URLTransform())
        path <- (map["path"], URLTransform())
    }
}
