//
//  WYNDoctor.swift
//
//  Created by Admin on 9/27/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNDoctor: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let pendingQuestions = "pending_questions"
        static let name = "name"
        static let id = "id"
        static let email = "email"
        static let speciality = "speciality"
        static let token = "token"
        static let createdAt = "created_at"
        static let avatar = "avatar"
        static let qualifications = "qualifications"
        static let online = "online"
        static let introduction = "introduction"
        static let answeredsHistory = "answereds_history"
        static let totalEarned = "total_earned"
    }
    
    // MARK: Properties
    public var pendingQuestions: Int?
    public var name: String?
    public var id: Int?
    public var email: String?
    public var speciality: String?
    public var token: String?
    public var createdAt: Int?
    public var avatar: String?
    public var qualifications: String?
    public var online: Bool? = false
    public var introduction: String?
    public var answeredsHistory: Int?
    public var totalEarned: String?
    
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
        pendingQuestions <- map[SerializationKeys.pendingQuestions]
        name <- map[SerializationKeys.name]
          id <- map[SerializationKeys.id]
        email <- map[SerializationKeys.email]
        speciality <- map[SerializationKeys.speciality]
        token <- map[SerializationKeys.token]
        createdAt <- map[SerializationKeys.createdAt]
        avatar <- map[SerializationKeys.avatar]
        qualifications <- map[SerializationKeys.qualifications]
        online <- map[SerializationKeys.online]
        introduction <- map[SerializationKeys.introduction]
        answeredsHistory <- map[SerializationKeys.answeredsHistory]
        totalEarned <- map[SerializationKeys.totalEarned]
    }
    
}
