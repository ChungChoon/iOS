//
//  SignUpStudentDataModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class SignUpStudentData: Mappable {

    var message : String?
    var user_mail: String?
    var user_pw: String?
    var user_name: String?
    var user_sex: Int?
    var user_hp: String?
    var user_birth: String?
    

    required init?(map: Map) {}

    func mapping(map: Map) {
        message <- map["message"]
        user_mail <- map["user_mail"]
        user_pw <- map["user_pw"]
        user_name <- map["user_name"]
        user_sex <- map["user_sex"]
        user_hp <- map["user_hp"]
        user_birth <- map["user_birth"]
    }
}
