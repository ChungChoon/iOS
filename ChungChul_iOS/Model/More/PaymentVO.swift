//
//  PaymentVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 21/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class PaymentVO: Mappable {
    
    var lecturePk: Int?
    var title: String?
    var applyTime: String?
    var price: Int?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        lecturePk <- map["lecture_pk"]
        title <- map["title"]
        applyTime <- map["apply_time"]
        price <- map["price"]
    }
    
}
