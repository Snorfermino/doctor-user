//
//  DoctorsResponse.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/18/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Mapper

class DoctorsResponse: Mappable {
    var ok: Bool?
    var doctors: [Doctor]?
    
    required init(map: Mapper) throws {
        try ok = map.from("ok")
        try doctors = map.from("results")
    }
}
