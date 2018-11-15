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
    
    //MARK: Request Login to Server
    func loginModel(email: String, password: String) {
        
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
                (response:DataResponse<LoginData>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "Success To Sign In" {
                        if let token = responseMessage.token, let data = responseMessage.data{
                            self.userDefaultSetting(token, data)
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
    
    //MARK: Set User Default when user logined
    func userDefaultSetting(_ token: String, _ data: [LoginDataVO]) {
        let ud = UserDefaults.standard
        ud.setValue(token, forKey: "token")
        ud.setValue(data[0].name, forKey: "name")
        ud.setValue(data[0].mail, forKey: "mail")
        ud.setValue(data[0].img, forKey: "img")
        ud.setValue(data[0].wallet, forKey: "wallet")
        ud.synchronize()
    }
}
