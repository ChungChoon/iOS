//
//  LectureDetailDataVO.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 06/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class LectureDetailDataVO: Mappable {
    
    var attendCnt: Int?
    var checkBuy: Int?
    var userPk: Int?
    var name: String?
    var img: String?
    var userGb: Int?
    var farmName: String?
    var farmImg: String?
    var lecturePk: Int?
    var title: String?
    var kind: Int?
    var startDate: String?
    var endDate: String?
    var regDate: String?
    var place: String?
    var curriculumCount: Int?
    var intro: String?
    var limitNum: String?
    var price: Int?
    var apply: Int?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        attendCnt <- map["attend_cnt"]
        checkBuy <- map["check_buy"]
        userPk <- map["user_pk"]
        name <- map["name"]
        img <- map["img"]
        userGb <- map["user_gb"]
        farmName <- map["farm_name"]
        farmImg <- map["farm_img"]
        lecturePk <- map["lecture_pk"]
        title <- map["title"]
        kind <- map["kind"]
        startDate <- map["start_date"]
        endDate <- map["end_date"]
        regDate <- map["reg_date"]
        place <- map["place"]
        curriculumCount <- map["curri_count"]
        intro <- map["intro"]
        limitNum <- map["limit_num"]
        price <- map["price"]
        apply <- map["apply"]
    }
}
