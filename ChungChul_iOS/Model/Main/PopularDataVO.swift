//
//  HomeDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class PopularDataVO: Mappable {
    
    var user_pk: Int?
    var mail: String?
    var name: String?
    var birth: String?
    var sex: Int?
    var hp: String?
    var img: String?
    var wallet_addr: String?
    var user_gb: Int?
    var farm_career: Int?
    var farm_name: String?
    var reg_num: Int?
    var farm_pk: Int?
    var farm_addr: String?
    var lecture_pk: Int?
    var title: String?
    var target: String?
    var kind: Int?
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
    var check_buy: Int?
    
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
        reg_num <- map["reg_num"]
        farm_career <- map["farm_career"]
        farm_name <- map["farm_name"]
        farm_addr <- map["farm_addr"]
        farm_pk <- map["farm_pk"]
        lecture_pk <- map["lecture_pk"]
        title <- map["title"]
        target <- map["target"]
        kind <- map["kind"]
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
        check_buy <- map["check_buy"]
    }
    
}
