//
//  LectureReviewDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 06/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class LectureReviewDataVO: Mappable {
    
    var userPk: Int?
    var name: String?
    var img: String?
    var title: String?
    var content: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        userPk <- map["user_pk"]
        name <- map["name"]
        img <- map["img"]
        title <- map["title"]
        content <- map["content"]
    }
    
}
