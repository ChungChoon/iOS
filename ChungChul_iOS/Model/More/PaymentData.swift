//
//  PaymentData.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 21/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class PaymentData: Mappable {
    
    var message: String?
    var data: [PaymentVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        data <- map["data"]
    }
}
