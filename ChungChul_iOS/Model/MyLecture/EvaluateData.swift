//
//  EvaluateData.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 09/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class EvaluateModel: Mappable {
    
    var message: String?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
    }
    
}
