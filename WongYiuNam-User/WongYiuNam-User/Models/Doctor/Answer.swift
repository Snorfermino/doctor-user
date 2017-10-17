//
//  Answer.swift
//  WongYiuNam-User
//
//  Created by Admin on 9/29/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct Answer: Mappable {
    
    var id: Int?
    var doctorId: Int?
    var questionId: Int?
    var answer: String?
    var audioUrl: URL?
    var duration: Int?
    var viewCount : Int?
    var listenCount : Int?
    var date: Date?
    var isFree: Bool?
    var createdAt: Date?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        doctorId <- map["doctor_id"]
        questionId <- map["question_id"]
        answer <- map["answer"]
        audioUrl <- (map["audio_url"], URLTransform())
        duration <- map["duration"]
        viewCount <- map["view_count"]
        listenCount <- map["listen_count"]
        date <- (map["date"], DateTransform())
        isFree <- map["is_free"]
        createdAt <- (map["created_at"], DateTransform())
    }
}
