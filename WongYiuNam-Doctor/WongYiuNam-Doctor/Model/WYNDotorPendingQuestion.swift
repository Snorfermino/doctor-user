//
//  WYNDotocPendingQuestion.swift
//
//  Created by Admin on 9/21/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNDotorPendingQuestion: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let data = "data"
        static let path = "path"
        static let from = "from"
        static let total = "total"
        static let lastPage = "last_page"
        static let perPage = "per_page"
        static let to = "to"
        static let currentPage = "current_page"
    }
    
    // MARK: Properties
    public var data: [WYNData]?
    public var path: String?
    public var from: Int?
    public var total: Int?
    public var lastPage: Int?
    public var perPage: Int?
    public var to: Int?
    public var currentPage: Int?
    
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
        data <- map[SerializationKeys.data]
        path <- map[SerializationKeys.path]
        from <- map[SerializationKeys.from]
        total <- map[SerializationKeys.total]
        lastPage <- map[SerializationKeys.lastPage]
        perPage <- map[SerializationKeys.perPage]
        to <- map[SerializationKeys.to]
        currentPage <- map[SerializationKeys.currentPage]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
        if let value = path { dictionary[SerializationKeys.path] = value }
        if let value = from { dictionary[SerializationKeys.from] = value }
        if let value = total { dictionary[SerializationKeys.total] = value }
        if let value = lastPage { dictionary[SerializationKeys.lastPage] = value }
        if let value = perPage { dictionary[SerializationKeys.perPage] = value }
        if let value = to { dictionary[SerializationKeys.to] = value }
        if let value = currentPage { dictionary[SerializationKeys.currentPage] = value }
        return dictionary
    }
    
}
extension WYNDotorPendingQuestion {
    
    public struct WYNData: Mappable {
        
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
        }
        
        // MARK: Properties
        public var symptomType: String?
        public var updatedAt: Int?
        public var doctorId: Int?
        public var status: Bool? = false
        public var patientName: String?
        public var id: Int?
        public var isPublic: Bool? = false
        public var createdAt: Int?
        public var patientGender: String?
        public var userId: Int?
        public var patientDob: Int?
        public var question: String?
        
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
            updatedAt <- map[SerializationKeys.updatedAt]
            doctorId <- map[SerializationKeys.doctorId]
            status <- map[SerializationKeys.status]
            patientName <- map[SerializationKeys.patientName]
            id <- map[SerializationKeys.id]
            isPublic <- map[SerializationKeys.isPublic]
            createdAt <- map[SerializationKeys.createdAt]
            patientGender <- map[SerializationKeys.patientGender]
            userId <- map[SerializationKeys.userId]
            patientDob <- map[SerializationKeys.patientDob]
            question <- map[SerializationKeys.question]
        }
        
        /// Generates description of the object in the form of a NSDictionary.
        ///
        /// - returns: A Key value pair containing all valid values in the object.
        public func dictionaryRepresentation() -> [String: Any] {
            var dictionary: [String: Any] = [:]
            if let value = symptomType { dictionary[SerializationKeys.symptomType] = value }
            if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
            if let value = doctorId { dictionary[SerializationKeys.doctorId] = value }
            dictionary[SerializationKeys.status] = status
            if let value = patientName { dictionary[SerializationKeys.patientName] = value }
            if let value = id { dictionary[SerializationKeys.id] = value }
            dictionary[SerializationKeys.isPublic] = isPublic
            if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
            if let value = patientGender { dictionary[SerializationKeys.patientGender] = value }
            if let value = userId { dictionary[SerializationKeys.userId] = value }
            if let value = patientDob { dictionary[SerializationKeys.patientDob] = value }
            if let value = question { dictionary[SerializationKeys.question] = value }
            return dictionary
        }
    }
}
