//
//  LoginModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 27/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class LoginModel: NetworkModel {
    
    func loginModel(email: String, password: String) {
        
        let ud = UserDefaults.standard
        let URL = "\(baseURL)/user/signin"
        let body : [String:String] = [
            "mail": email,
            "passwd": password
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseObject{
                (response:DataResponse<LoginDataModel>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "Success To Sign In" {
                        if let token = responseMessage.token{
                            ud.setValue(token, forKey: "token")
                            ud.synchronize()
                            print(token)
                        }
                        if let data = responseMessage.data{
                            ud.setValue(data[0].name, forKey: "name")
                            ud.setValue(data[0].mail, forKey: "mail")
                            ud.setValue(data[0].img, forKey: "img")
                            ud.setValue(data[0].private_key, forKey: "private_key")
                            ud.setValue(data[0].flag, forKey: "flag")
                            ud.setValue(data[0].birth, forKey: "birth")
                            ud.setValue(data[0].hp, forKey: "hp")
                            ud.setValue(data[0].sex, forKey: "sex")
                            ud.synchronize()
                        }
                        self.view.networkResult(resultData: "Login Success", code: "Success To Sign In")
                    }
                    else if responseMessage.message == "Null Value" {
                        self.view.networkResult(resultData: "400ERR", code: "Null Value")
                    }
                    else if responseMessage.message == "Internal Server Error"{
                        self.view.networkResult(resultData: "500ERR", code: "Internal Server Error")
                    }
                    else if responseMessage.message == "Fail To Sign In"{
                        self.view.networkResult(resultData: "아이디 또는 패스워드를 확인해주세요.", code: "Fail To Sign In")
                    }
                    
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
    
}
