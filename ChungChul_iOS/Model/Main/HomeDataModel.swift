//
//  HomeDataModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class HomeDataModel: Mappable {
    
    var message: String?
    var popular: [PopularDataVO]?
    var offline: [OfflineDataVO]?
    var online: [OnlineDataVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        popular <- map["popular"]
        offline <- map["offline"]
        online <- map["online"]
    }
    
}
