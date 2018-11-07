//
//  LectureDetailData.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 06/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import ObjectMapper

class LectureDetailData: Mappable {
    
    var message: String?
    var lectureData: LectureDetailDataVO?
    var reviewData: [LectureReviewDataVO]?
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        message <- map["message"]
        lectureData <- map["lecture_data"]
        reviewData <- map["review_data"]
    }
    
}
