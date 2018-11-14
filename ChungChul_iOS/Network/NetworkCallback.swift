//
//  NetworkCallback.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

//MARK: Protocol for receiving responses from Server
protocol NetworkCallback {
    func networkResult(resultData:Any, code:String)
    func networkFailed()
}
