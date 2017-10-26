//
//  WYNRecordAnswerResult.swift
//
//  Created by Admin on 10/4/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNRecordAnswerResult: Mappable {
  private struct SerializationKeys {
    static let id = "id"
    static let audioUrl = "audio_url"
    static let createdAt = "created_at"
    static let listentCount = "listent_count"
    static let duration = "duration"
    static let isFree = "is_free"
    static let question = "question"
  }
  public var id: Int?
  public var audioUrl: URL?
  public var createdAt: Date?
  public var listentCount: Int?
  public var duration: Int?
  public var isFree: Bool? = false
  public var question: WYNQuestion?
  public init?(map: Map){}
  public mutating func mapping(map: Map) {
    id <- map[SerializationKeys.id]
    audioUrl <- (map[SerializationKeys.audioUrl], URLTransform())
    createdAt <- (map[SerializationKeys.createdAt], DateTransform())
    listentCount <- map[SerializationKeys.listentCount]
    duration <- map[SerializationKeys.duration]
    isFree <- map[SerializationKeys.isFree]
    question <- map[SerializationKeys.question]
  }
}
