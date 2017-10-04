//
//  WYNQuestion.swift
//
//  Created by Admin on 10/3/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public struct WYNQuestion: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let symptomType = "symptom_type"
        static let updatedAt = "updated_at"
        static let doctorId = "doctor_id"
        static let status = "status"
        static let patientName = "patient_name"
        static let id = "id"
        static let isPublic = "is_public"
        static let createdAt = "created_at"
        static let patientGender = "patient_gender"
        static let userId = "user_id"
        static let patientDob = "patient_dob"
        static let question = "question"
        static let photoUrl = "photo_url"
    }
    
    // MARK: Properties
    public var symptomType: String?
    public var updatedAt: Date?
    public var doctorId: Int?
    public var status: Bool? = false
    public var patientName: String?
    public var id: Int?
    public var isPublic: Bool? = false
    public var createdAt: Date?
    public var patientGender: String?
    public var userId: Int?
    public var patientDob: Int?
    public var question: String?
    public var photoUrl: URL?
    
    // MARK: ObjectMapper Initializers
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public init?(map: Map){
        
    }
    
    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public mutating func mapping(map: Map) {
        symptomType <- map[SerializationKeys.symptomType]
        updatedAt <- (map[SerializationKeys.updatedAt], DateTransform())
        doctorId <- map[SerializationKeys.doctorId]
        status <- map[SerializationKeys.status]
        patientName <- map[SerializationKeys.patientName]
        id <- map[SerializationKeys.id]
        isPublic <- map[SerializationKeys.isPublic]
        createdAt <- (map[SerializationKeys.createdAt], DateTransform())
        patientGender <- map[SerializationKeys.patientGender]
        userId <- map[SerializationKeys.userId]
        patientDob <- map[SerializationKeys.patientDob]
        question <- map[SerializationKeys.question]
        photoUrl <- (map[SerializationKeys.photoUrl], URLTransform())
    }
}
