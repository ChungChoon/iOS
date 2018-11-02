//
//  MyLectureVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 03/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class MyLectureVO: Mappable {
    
    var user_pk: Int?
    var mail: String?
    var name: String?
    var birth: String?
    var sex: Int?
    var hp: String?
    var img: String?
    var wallet_addr: String?
    var user_gb: Int?
    var farmer_career: Int?
    var farm_name: String?
    var reg_num: Int?
    var farm_pk: Int?
    var farm_addr: String?
    var subject: String?
    var kind: Int?
    var farm_img: String?
    var title: String?
    var target: Int?
    var period: Int?
    var start_date: String?
    var end_date: String?
    var reg_date: String?
    var place: String?
    var curriculum: String?
    var intro: String?
    var limit_num: Int?
    var price: Int?
    var apply: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        user_pk <- map["user_pk"]
        mail <- map["mail"]
        name <- map["name"]
        birth <- map["birth"]
        sex <- map["sex"]
        hp <- map["hp"]
        img <- map["img"]
        wallet_addr <- map["wallet_addr"]
        user_gb <- map["user_gb"]
        farmer_career <- map["farmer_career"]
        farm_name <- map["farm_name"]
        reg_num <- map["reg_num"]
        farm_pk <- map["farm_pk"]
        farm_addr <- map["farm_addr"]
        subject <- map["subject"]
        kind <- map["kind"]
        farm_img <- map["farm_img"]
        title <- map["title"]
        target <- map["target"]
        period <- map["period"]
        start_date <- map["start_date"]
        end_date <- map["end_date"]
        reg_date <- map["reg_date"]
        place <- map["place"]
        curriculum <- map["curriculum"]
        intro <- map["intro"]
        limit_num <- map["limit_num"]
        price <- map["price"]
        apply <- map["apply"]
    }
    
}
