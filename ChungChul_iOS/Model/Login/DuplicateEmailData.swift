//
//  DuplicateEmailModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class DuplicateEmailData: Mappable {
    
    var message : String?

    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
    }
    
}
