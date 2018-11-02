//
//  StudentJoinModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class JoinModel : NetworkModel{
    
    func duplicateEmailModel(mail: String) {

        let URL = "\(baseURL)/user/dupcheck/mail"
        let body : [String:String] = [
            "mail": mail
        ]

        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseObject{
                (response:DataResponse<DuplicateEmailDataModel>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "duplication" {
                        self.view.networkResult(resultData: "중복된 이메일 입니다.", code: "duplication")
                    }
                    else if responseMessage.message == "available" {
                        self.view.networkResult(resultData: "사용 가능한 이메일 입니다.", code: "available")
                    }


                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    
    func joinStudentModel(mail: String, passwd: String, name: String, sex: Int, hp: String, birth: String, private_key: String, wallet: String) {
        
        let URL = "\(baseURL)/user/signup"
        let body : [String:Any] = [
            "mail": mail,
            "passwd": passwd,
            "name": name,
            "sex": sex,
            "hp": hp,
            "birth": birth,
            "private_key": private_key,
            "wallet": wallet
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseObject{
                (response:DataResponse<SignUpStudentDataModel>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    print(responseMessage.message)
                    if responseMessage.message == "Success To Sign Up" {
                        self.view.networkResult(resultData: "Success Sign Up", code: "Success To Sign Up")
                    }
                    else if responseMessage.message == "Null Value" {
                        self.view.networkResult(resultData: "400ERROR", code: "Null Value")
                    }
                    else if responseMessage.message == "Internal Server Error"{
                        self.view.networkResult(resultData: "500ERROR", code: "Internal Server Error")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
    func joinTeacherModel(mail: String, passwd: String, name: String, sex: Int, hp: String, birth: String, career: Int, private_key: String, wallet: String, farm_addr: String, farm_num: String, farm_name: String) {
        
        let URL = "\(baseURL)/user/signup/farmer"
        let body : [String:Any] = [
            "mail": mail,
            "passwd": passwd,
            "name": name,
            "sex": sex,
            "hp": hp,
            "birth": birth,
            "career": career,
            "private_key": private_key,
            "wallet": wallet,
            "farm_addr": farm_addr,
            "farm_num": farm_num,
            "farm_name": farm_name
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseObject{
                (response:DataResponse<SignUpStudentDataModel>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "Success To Sign Up" {
                        self.view.networkResult(resultData: "Success Sign Up", code: "Success To Sign Up")
                    }
                    else if responseMessage.message == "Null Value" {
                        self.view.networkResult(resultData: "400ERROR", code: "Null Value")
                    }
                    else if responseMessage.message == "Internal Server Error"{
                        self.view.networkResult(resultData: "500ERROR", code: "Internal Server Error")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
}
