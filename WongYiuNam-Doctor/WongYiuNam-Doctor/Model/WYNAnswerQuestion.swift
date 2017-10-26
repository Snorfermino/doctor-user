//
//  WYNAnswerQuestionParameters.swift
//  WongYiuNam-Doctor
//
//  Created by Admin on 9/27/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNAnswerQuestion: Mappable {
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
    public init?(){}

    /// Map a JSON object to this class using ObjectMapper.
    ///
    /// - parameter map: A mapping from ObjectMapper.
    public mutating func mapping(map: Map) {
        questionID <- map[SerializationKeys.questionID]
        isFree <- map[SerializationKeys.isFree]
        duration <- map[SerializationKeys.duration]
        audio <- (map[SerializationKeys.audio],URLTransform())
    }
}
