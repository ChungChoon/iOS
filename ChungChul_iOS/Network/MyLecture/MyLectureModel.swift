//
//  MyLectureModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 08/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class MyLectureModel: NetworkModel {
    
    func callMyLectureList(token: String) {
        
        let URL = "\(baseURL)/student"
        
        Alamofire.request(
            URL,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: ["token":token]
            ).responseObject{
                (response:DataResponse<MyLectureData>) in
                switch response.result {
                case .success:
                    guard let responseData = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseData.message == "Success To Get Farmer My Lecture" {
                        self.view.networkResult(resultData: responseData.data, code: "Success To Get Farmer My Lecture")
                    }
                    
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
}
