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
    var onlineData: [MyLectureVO]?
    var offlineData: [MyLectureVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        onlineData <- map["online_data"]
        offlineData <- map["offline_data"]
    }
    
}
