//
//  KlaytnExtention.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 12/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import web3swift

extension UIView {
    
    //MARK: Get Evaluation Average Point to String at the Klaytn
    func getEvaluationAveragePointText(_ lectureNumber: Int?) -> String{
        var value: Int?
        do {
            let contractAddress = CaverSingleton.sharedInstance.contractAddress
            value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber!).wait().intCount()
        } catch{
            print("No Evaluation Point")
        }
        if value != nil{
            return "\(value!)%"
        } else {
            return "평가가 없습니다."
        }
    }
    
    //MARK: Get Evaluation Average Point to Int at the Klaytn
    func getEvaluationAveragePoint(_ lectureNumber: Int?) -> Int{
        var value: Int?
        do {
            let contractAddress = CaverSingleton.sharedInstance.contractAddress
            value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber!).wait().intCount()
        } catch{
            print("No Evaluation Point")
        }
        if value != nil{
            return value!
        } else {
            return 0
        }
    }
    
    //MARK: Use Evaluation Average Point to get RateView Index
    func getRateViewIndexByEvaluationPoint(_ evaluationPoint: Int?) -> Int?{
        if let point = evaluationPoint {
            if point == 100{
                return 4
            } else if point >= 80 && point < 100{
                return 3
            } else if point >= 60 && point < 80 {
                return 2
            } else if point >= 40 && point < 60 {
                return 1
            } else if point >= 20 && point < 40 {
                return 0
            } else {
                return nil
            }
        } else {
            return nil
        }
    }
}
