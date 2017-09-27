//
//  WYNAnswerQuestionParameters.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNAnswerQuestionParameters: Mappable {
    // MARK: Declaration for string constants to be used to decode and also serialize.
    private struct SerializationKeys {
        static let questionID = "question_id"
        static let isFree = "is_free"
        static let duration = "duration"
        static let audio = "audio"
    }
    
    // MARK: Properties
    public var questionID: Int?
    public var isFree: Bool?
    public var duration: Int?
    public var audio: URL?
    
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
        questionID <- map[SerializationKeys.questionID]
        isFree <- map[SerializationKeys.isFree]
        duration <- map[SerializationKeys.duration]
        audio <- map[SerializationKeys.audio]
    }
    
    /// Generates description of the object in the form of a NSDictionary.
    ///
    /// - returns: A Key value pair containing all valid values in the object.
    public func dictionaryRepresentation() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        if let value = questionID { dictionary[SerializationKeys.questionID] = value }
        if let value = isFree { dictionary[SerializationKeys.isFree] = value }
        if let value = duration { dictionary[SerializationKeys.duration] = value }
        if let value = audio { dictionary[SerializationKeys.audio] = value }
        return dictionary
    }
}
