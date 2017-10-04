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
        static let prevPageUrl = "prev_page_url"
        static let from = "from"
        static let total = "total"
        static let lastPage = "last_page"
        static let perPage = "per_page"
        static let nextPageUrl = "next_page_url"
        static let to = "to"
        static let currentPage = "current_page"
    }
    
    // MARK: Properties
    public var data: [WYNData]?
    public var path: String?
    public var prevPageUrl: String?
    public var from: Int?
    public var total: Int?
    public var lastPage: Int?
    public var perPage: Int?
    public var nextPageUrl: String?
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
        prevPageUrl <- map[SerializationKeys.prevPageUrl]
        from <- map[SerializationKeys.from]
        total <- map[SerializationKeys.total]
        lastPage <- map[SerializationKeys.lastPage]
        perPage <- map[SerializationKeys.perPage]
        nextPageUrl <- map[SerializationKeys.nextPageUrl]
        to <- map[SerializationKeys.to]
        currentPage <- map[SerializationKeys.currentPage]
    }
}
extension WYNAnswerHistory{
    public struct WYNData: Mappable {
        
        // MARK: Declaration for string constants to be used to decode and also serialize.
        private struct SerializationKeys {
            static let id = "id"
            static let audioUrl = "audio_url"
            static let createdAt = "created_at"
            static let listentCount = "listent_count"
            static let duration = "duration"
            static let isFree = "is_free"
            static let question = "question"
        }
        
        // MARK: Properties
        public var id: Int?
        public var audioUrl: String?
        public var createdAt: Date?
        public var listentCount: Int?
        public var duration: Int?
        public var isFree: Bool? = false
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
            id <- map[SerializationKeys.id]
            audioUrl <- map[SerializationKeys.audioUrl]
            createdAt <- (map[SerializationKeys.createdAt], DateTransform())
            listentCount <- map[SerializationKeys.listentCount]
            duration <- map[SerializationKeys.duration]
            isFree <- map[SerializationKeys.isFree]
            question <- map[SerializationKeys.question]
        }
}
}
