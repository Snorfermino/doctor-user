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
            static let status = "status"
            static let updatedAt = "updated_at"
            static let id = "id"
            static let symptoms = "symptoms"
            static let doctorId = "doctor_id"
            static let answer = "answer"
            static let createdAt = "created_at"
            static let userId = "user_id"
            static let duration = "duration"
            static let question = "question"
        }
        
        // MARK: Properties
        public var status: Bool? = false
        public var updatedAt: Int?
        public var id: Int?
        public var symptoms: String?
        public var doctorId: Int?
        public var answer: String?
        public var createdAt: Int?
        public var userId: Int?
        public var duration: Int?
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
            status <- map[SerializationKeys.status]
            updatedAt <- map[SerializationKeys.updatedAt]
            id <- map[SerializationKeys.id]
            symptoms <- map[SerializationKeys.symptoms]
            doctorId <- map[SerializationKeys.doctorId]
            answer <- map[SerializationKeys.answer]
            createdAt <- map[SerializationKeys.createdAt]
            userId <- map[SerializationKeys.userId]
            duration <- map[SerializationKeys.duration]
            question <- map[SerializationKeys.question]
        }
        
        /// Generates description of the object in the form of a NSDictionary.
        ///
        /// - returns: A Key value pair containing all valid values in the object.
        public func dictionaryRepresentation() -> [String: Any] {
            var dictionary: [String: Any] = [:]
            dictionary[SerializationKeys.status] = status
            if let value = updatedAt { dictionary[SerializationKeys.updatedAt] = value }
            if let value = id { dictionary[SerializationKeys.id] = value }
            if let value = symptoms { dictionary[SerializationKeys.symptoms] = value }
            if let value = doctorId { dictionary[SerializationKeys.doctorId] = value }
            if let value = answer { dictionary[SerializationKeys.answer] = value }
            if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
            if let value = userId { dictionary[SerializationKeys.userId] = value }
            if let value = duration { dictionary[SerializationKeys.duration] = value }
            if let value = question { dictionary[SerializationKeys.question] = value }
            return dictionary
        }
        
    }
    
}
