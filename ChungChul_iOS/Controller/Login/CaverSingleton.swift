//
//  KeystoreSingleton.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 04/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import Foundation
import web3swift

final class CaverSingleton {
    static let sharedInstance = CaverSingleton()
    
    init(){
        Web3.default = .init(provider: Web3HttpProvider.init(URL(string: "http://localhost:8551")!)!)
    }
    
    let caver: Web3 = Web3(url: URL(string: "http://localhost:8551")!)!
    var userAddress: Address = Address("0xf694888fC6EEA44F8Cd03E9c5f18af8F61BdEbe8")
    let contractAddress = Address("0x024796f002397ee8356c3d4fedb45219fd37d8ab")
    
    func keystoreMangaerInDevice() -> KeystoreManager?{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore"
        let keystoreManager =  KeystoreManager.managerForPath(path)
        return keystoreManager
    }
    
    let contractABI = "[{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"acceptAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"createLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"_preparation_point\",\"type\": \"uint256\"},{\"name\": \"_content_point\",\"type\": \"uint256\"},{\"name\": \"_proceed_point\",\"type\": \"uint256\"},{\"name\": \"_communication_point\",\"type\": \"uint256\"},{\"name\": \"_satisfaction_point\",\"type\": \"uint256\"}],\"name\": \"evaluateLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"payBalance\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"purchaseLecture\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"recreateLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"transferOwnership\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"inputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"id\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"teacher\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"CreatingLecture\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"lectureID\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"voter\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"votes\",\"type\": \"uint256\"}],\"name\": \"Evaluating\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"previousOwner\",\"type\": \"address\"},{\"indexed\": true,\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"OwnershipTransferred\",\"type\": \"event\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"calculateEvaluationAveragePoint\",\"outputs\": [{\"name\": \"averagePoint\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureFee\",\"type\": \"uint256\"},{\"name\": \"percent\",\"type\": \"uint256\"}],\"name\": \"calculateIncentiveCost\",\"outputs\": [{\"name\": \"incentiveCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"getLectureCount\",\"outputs\": [{\"name\": \"lectureCount\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureEvaluationPoint\",\"outputs\": [{\"name\": \"evaluationCount\",\"type\": \"uint256\"},{\"name\": \"preparation_point\",\"type\": \"uint256\"},{\"name\": \"content_point\",\"type\": \"uint256\"},{\"name\": \"proceed_point\",\"type\": \"uint256\"},{\"name\": \"communication_point\",\"type\": \"uint256\"},{\"name\": \"satisfaction_point\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureID\",\"outputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureTotalCost\",\"outputs\": [{\"name\": \"totalLectureCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lectureIDs\",\"outputs\": [{\"name\": \"\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"owner\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"}]"
    
}
