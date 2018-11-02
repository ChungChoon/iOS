//
//  OnlineDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class OnlineDataVO: Mappable {
    
    var message: String?
    var data: [LoginDataVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
    
}
