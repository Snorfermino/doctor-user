//
//  PostFB.swift
//  WongYiuNam-User
//
//  Created by Admin on 10/5/17.
//  Copyright © 2017 RTH. All rights reserved.
//

import ObjectMapper

struct PostFB: Mappable {
    
    var likesCount: Int?
    var commentsCount: Int?
    var message: String?
    var attachmentUrl: URL?
    var attachmentTitle: String?
    var attachmentImage: URL?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        likesCount <- map["likes.summary.total_count"]
        commentsCount <- map["comments.summary.total_count"]
        message <- map["message"]
        attachmentUrl <- (map["attachments.data.0.url"], URLTransform())
        attachmentTitle <- map["attachments.data.0.title"]
        attachmentImage <- (map["attachments.data.0.media.image.src"], URLTransform())
    }
}
