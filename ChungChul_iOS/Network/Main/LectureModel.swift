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
    
    func totalLectureCall(token: String) {
        
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
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "Success To Get Information" {
                        self.view.networkResult(resultData: responseMessage, code: "Success To Get Information")
                    }
                    
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    func purchaseLectureModel(token: String, lecture_id: Int) {
        
        let URL = "\(baseURL)/lecture/apply"
        
        let body : [String: Int] = [
            "lecture_id": lecture_id
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
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "success to apply lecture" {
                        self.view.networkResult(resultData: responseMessage, code: "success to apply lecture")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
}
