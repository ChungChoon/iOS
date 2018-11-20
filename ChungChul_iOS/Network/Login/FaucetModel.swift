//
//  FaucetModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 20/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

class FaucetModel: NetworkModel {
    
    //MARK: Request Login to Server
    func faucetModel(addr: String) {
        
        let URL = "\(baseURL)/user/faucet"
        let body : [String:String] = [
            "addr": addr
        ]
        
        Alamofire.request(
            URL,
            method: .post,
            parameters: body,
            encoding: JSONEncoding.default,
            headers: nil
            ).responseObject{
                (response:DataResponse<DuplicateEmailData>) in
                switch response.result {
                case .success:
                    guard let responseMessage = response.result.value else{
                        self.view.networkFailed()
                        return
                    }
                    if responseMessage.message == "success" {
                        self.view.networkResult(resultData: "success", code: "Faucet Success")
                    }
                    else if responseMessage.message == "fail" {
                        self.view.networkResult(resultData: "fail", code: "Faucet Fail")
                    }
                case .failure(let err):
                    print(err)
                    self.view.networkFailed()
                }
        }
    }
}
