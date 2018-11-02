//
//  LoginDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class LoginDataVO: Mappable {
    
    var mail: String?
    var name: String?
    var passwd: String?
    var private_key: String?
    var birth: String?
    var sex: Int?
    var hp: String?
    var img: String?
    var flag: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        mail <- map["mail"]
        name <- map["name"]
        passwd <- map["passwd"]
        private_key <- map["private_key"]
        birth <- map["birth"]
        sex <- map["sex"]
        hp <- map["hp"]
        img <- map["img"]
        flag <- map["flag"]
    }
    
}
