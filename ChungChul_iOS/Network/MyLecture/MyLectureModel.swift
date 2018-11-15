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
    
    //MARK: Request My Lecture List to Server
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
                        self.view.networkResult(resultData: responseData, code: "Success To Get Farmer My Lecture")
                    }
                    
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    //MARK: Request Evaluate Lecture when Transaction successed
    func evaluateLecture(token: String, lecture_id: Int, content: String) {
        
        let URL = "\(baseURL)/lecture/evaluate"
        let body : [String:Any] = [
            "lecture_id": lecture_id,
            "content": content
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: ["token": token]
            ).responseObject{
                (response:DataResponse<EvaluateModel>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "success to evaluate lecture" {
                        self.view.networkResult(resultData: "Success Sign Up", code: "success to evaluate lecture")
                    }
                    else {
                        self.view.networkResult(resultData: responseMessage.message, code: "error")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
}
