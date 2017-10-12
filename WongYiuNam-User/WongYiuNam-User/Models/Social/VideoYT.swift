//
//  VideoYT.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/5/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct VideoYT: Mappable {
    
    var title: String?
    var videoID: String?
    var channelID: String?
    var channelTitle: String?
    var description: String?
    var publishedAt: String?
    var thumbnail: URL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        title <- map["snippet.title"]
        videoID <- map["id.videoId"]
        channelID <- map["snippet.channelId"]
        channelTitle <- map["snippet.channelTitle"]
        description <- map["snippet.description"]
        publishedAt <- map["snippet.publishedAt"]
        thumbnail <- (map["snippet.thumbnails.medium.url"], URLTransform())
    }
}
