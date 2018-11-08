//
//  LectureModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class LectureModel: NetworkModel {
    
    func callLectureList(token: String) {
        
        let URL = "\(baseURL)/home"
        
        Alamofire.request(
            URL,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: ["token":token]
            ).responseObject{
                (response:DataResponse<HomeDataModel>) in
                switch response.result {
                case .success:
                    guard let responseData = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseData.message == "Success To Get Information" {
                        self.view.networkResult(resultData: responseData, code: "Success To Get Information")
                    }
                    
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    func callLectureDetail(lectureId: Int, token: String) {
        
        let URL = "\(baseURL)/lecture/\(lectureId)"
        
        Alamofire.request(
            URL,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: ["token":token]
            ).responseObject{
                (response:DataResponse<LectureDetailData>) in
                switch response.result {
                case .success:
                    guard let responseData = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseData.message == "Success Get Lecture Detail" {
                        self.view.networkResult(resultData: responseData, code: "Success Get Lecture Detail")
                    }
                    
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    func purchaseLectureModel(token: String, lecture_id: Int, price: Int) {
        
        let URL = "\(baseURL)/lecture/apply"
        
        let body : [String: Int] = [
            "lecture_id": lecture_id,
            "price": price
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: ["token": token]
            ).responseObject{
                (response:DataResponse<HomeDataModel>) in
                switch response.result {
                case .success:
                    guard let responseData = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseData.message == "success to apply lecture" {
                        self.view.networkResult(resultData: responseData, code: "success to apply lecture")
                    } else {
                        self.view.networkResult(resultData: responseData.message!, code: "error")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
}
