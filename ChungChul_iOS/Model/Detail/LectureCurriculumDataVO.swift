//
//  LectureCurriculumDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 15/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class LectureCurriculumDataVO: Mappable {
    
    var title: String?
    var content: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        title <- map["title"]
        content <- map["content"]
    }
    
}
