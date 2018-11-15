//
//  HomeDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class PopularDataVO: Mappable {
    
    var userPk: Int?
    var name: String?
    var img: String?
    var userGb: String?
    var farmName: String?
    var farmImg: String?
    var lecturePk: Int?
    var title: String?
    var kind: Int?
    var startDate: String?
    var endDate: String?
    var regDate: String?
    var place: String?
    var curriculum: String?
    var intro: String?
    var limitNum: Int?
    var price: Int?
    var apply: Int?
    var curriculumCount: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        curriculumCount <- map["curri_count"]
        userPk <- map["user_pk"]
        name <- map["name"]
        img <- map["img"]
        userGb <- map["user_gb"]
        farmName <- map["farm_name"]
        lecturePk <- map["lecture_pk"]
        title <- map["title"]
        kind <- map["kind"]
        startDate <- map["start_date"]
        endDate <- map["end_date"]
        regDate <- map["reg_date"]
        place <- map["place"]
        curriculum <- map["curriculum"]
        intro <- map["intro"]
        limitNum <- map["limit_num"]
        price <- map["price"]
        apply <- map["apply"]
    }
    
}
