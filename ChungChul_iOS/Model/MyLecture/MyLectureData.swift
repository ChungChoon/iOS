//
//  MyLectureData.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 03/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class MyLectureData: Mappable {
    
    var message: String?
    var data: [MyLectureVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
    
}
