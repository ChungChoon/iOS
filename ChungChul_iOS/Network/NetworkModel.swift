//
//  NetworkModel.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 26/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

//MARK: API Server Network URL Setting
class NetworkModel {
    
    var view : NetworkCallback
    
    init(_ vc : NetworkCallback){
        self.view = vc
    }
    
    let baseURL = "http://52.79.137.94:3000"
}
