//
//  Doctor.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

class Doctor: Mappable {
    var id: Int?
    var name: String?
    var avatar: String?
    var introduction: String?
    var qualifications: String?
    var specialty: String?
    var status: Bool?
    
    init() {
        id = 0
        name = ""
        avatar = ""
        introduction = ""
        qualifications = ""
        specialty = ""
        status = false
    }
    
    required init(map: Mapper) throws {
        try id = map.from("id")
        try name = map.from("name")
        try avatar = map.from("avatar")
        try introduction = map.from("introduction")
        try qualifications = map.from("qualifications")
        try specialty = map.from("specialty")
        var tempStatus: Int?
        try tempStatus = map.from("status")
        if(tempStatus == 1) {
            status = true
        } else {
            status = false
        }
    }
}
