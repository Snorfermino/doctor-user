//
//  WYNAnswerDetail.swift
//
//  Created by Admin on 10/3/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNAnswerHistory: Mappable {
    
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
}
extension WYNAnswerHistory{
    public struct WYNData: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        private struct SerializationKeys {
            static let questionId = "question_id"
            static let audioUrl = "audio_url"
            static let doctorId = "doctor_id"
            static let date = "date"
            static let listenCount = "listen_count"
            static let isFree = "is_free"
            static let viewCount = "view_count"
            static let id = "id"
            static let createdAt = "created_at"
            static let answer = "answer"
            static let doctor = "doctor"
            static let duration = "duration"
            static let question = "question"
        }
        
        // MARK: Properties
        public var questionId: Int?
        public var audioUrl: String?
        public var doctorId: Int?
        public var date: Int?
        public var listenCount: Int?
        public var isFree: Bool? = false
        public var viewCount: Int?
        public var id: Int?
        public var createdAt: Date?
        public var answer: String?
        public var doctor: WYNDoctor?
        public var duration: Int?
        public var question: WYNQuestion?
        
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
            questionId <- map[SerializationKeys.questionId]
            audioUrl <- map[SerializationKeys.audioUrl]
            doctorId <- map[SerializationKeys.doctorId]
            date <- map[SerializationKeys.date]
            listenCount <- map[SerializationKeys.listenCount]
            isFree <- map[SerializationKeys.isFree]
            viewCount <- map[SerializationKeys.viewCount]
            id <- map[SerializationKeys.id]
            createdAt <- (map[SerializationKeys.createdAt], DateTransform())
            answer <- map[SerializationKeys.answer]
            doctor <- map[SerializationKeys.doctor]
            duration <- map[SerializationKeys.duration]
            question <- map[SerializationKeys.question]
        }
    }
}
