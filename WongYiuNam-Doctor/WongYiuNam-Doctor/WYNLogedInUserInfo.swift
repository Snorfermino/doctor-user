//
//  WYNLogedInUserInfo.swift
//
//  Created by Admin on 9/26/17
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper
public struct WYNLogedInUserInfo: Mappable {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let name = "name"
    static let email = "email"
    static let id = "id"
    static let token = "token"
    static let createdAt = "created_at"
  }

  // MARK: Properties
  public var name: String?
  public var email: String?
  public var id: Int?
  public var token: String?
  public var createdAt: Int?

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
    name <- map[SerializationKeys.name]
    email <- map[SerializationKeys.email]
    id <- map[SerializationKeys.id]
    token <- map[SerializationKeys.token]
    createdAt <- map[SerializationKeys.createdAt]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = email { dictionary[SerializationKeys.email] = value }
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = token { dictionary[SerializationKeys.token] = value }
    if let value = createdAt { dictionary[SerializationKeys.createdAt] = value }
    return dictionary
  }

}
