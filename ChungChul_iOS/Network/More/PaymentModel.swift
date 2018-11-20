//
//  PaymentModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 21/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class PaymentModel: NetworkModel {
    
    //MARK: Request My Lecture List to Server
    func callMyPaymentDetailList(token: String) {
        
        let URL = "\(baseURL)/student/buylist"
        
        Alamofire.request(
            URL,
            method: .get,
            parameters: nil,
            encoding: JSONEncoding.default,
            headers: ["token":token]
            ).responseObject{
                (response:DataResponse<PaymentData>) in
                switch response.result {
                case .success:
                    guard let responseData = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseData.message == "Success To Get My Buy List" {
                        self.view.networkResult(resultData: responseData.data, code: "Success To Get My Buy List")
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
                (response:DataResponse<EvaluateData>) in
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
