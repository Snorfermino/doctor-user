//
//  BrainTreeToken.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/11/17.
//  Copyright © 2017 RTH. All rights reserved.
//
import ObjectMapper

struct BrainTreeToken: Mappable {
    var token: String?
    init?(map: Map) {}
    init() {}
    mutating func mapping(map: Map) {
        token <- map["braintree_token"]
    }
}

