//
//  WYNRecordAnswerResult.swift
//
//  Created by Admin on 10/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNRecordAnswerResult: Mappable {

    // TODO: for date type, please use DateTransform()
    // TODO: for URL type, please use URLTransform()
    
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
  public var audioUrl: URLTransform?
  public var createdAt: DateTransform?
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
    createdAt <- map[SerializationKeys.createdAt]
    listentCount <- map[SerializationKeys.listentCount]
    duration <- map[SerializationKeys.duration]
    isFree <- map[SerializationKeys.isFree]
    question <- map[SerializationKeys.question]
  }

}
