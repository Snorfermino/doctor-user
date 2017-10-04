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
    public var data: [WYNQuestion]?
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

