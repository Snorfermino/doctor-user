//
//  Question.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/12/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct Question: Mappable {
    var id : Int?
    var userId : Int?
    var doctorId : Int?
    var patientName : String?
    var patientDob : Int?
    var patientGender : String?
    var symptomType : String?
    var isPublic : String?
    var question : String?
    var photoUrl : URL?
    var status : String?
    var createdAt : Date?
    var updatedAt : Date?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        id <- map["id"]
        userId <- map["user_id"]
        doctorId <- map["doctor_id"]
        patientName <- map["patient_name"]
        patientDob <- map["patient_dob"]
        patientGender <- map["patient_gender"]
        symptomType <- map["symptom_type"]
        isPublic <- map["is_public"]
        question <- map["question"]
        photoUrl <- (map["photo_url"], URLTransform())
        status <- map["status"]
        createdAt <- (map["created_at"], DateTransform())
        updatedAt <- (map["updated_at"], DateTransform())
    }
}
