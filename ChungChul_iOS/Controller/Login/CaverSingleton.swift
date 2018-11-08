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
    
    init(){}
    
    let caver: Web3 = Web3(url: URL(string: "http://52.78.62.162:8551")!)!
    var userAddress: Address = Address("0xf694888fC6EEA44F8Cd03E9c5f18af8F61BdEbe8")
    let contractAddress = Address("0xef1491ba2a46c0e0f0a5160f261b24f60e276289")
    

    func keystoreMangaerInDevice() -> KeystoreManager?{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore"
        
        let keystoreManager =  KeystoreManager.managerForPath(path)
        return keystoreManager
    }
    
    let contractABI = "[{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"acceptAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"_preparation_point\",\"type\": \"uint256\"},{\"name\": \"_content_point\",\"type\": \"uint256\"},{\"name\": \"_proceed_point\",\"type\": \"uint256\"},{\"name\": \"_communication_point\",\"type\": \"uint256\"},{\"name\": \"_satisfaction_point\",\"type\": \"uint256\"}],\"name\": \"evaluateLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"lectureCreate\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"payBalance\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"purchaseLecture\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"transferOwnership\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"inputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"id\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"teacher\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"CreatingLecture\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"lectureID\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"voter\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"votes\",\"type\": \"uint256\"}],\"name\": \"Evaluating\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"previousOwner\",\"type\": \"address\"},{\"indexed\": true,\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"OwnershipTransferred\",\"type\": \"event\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureFee\",\"type\": \"uint256\"},{\"name\": \"percent\",\"type\": \"uint256\"}],\"name\": \"calculateIncentiveCost\",\"outputs\": [{\"name\": \"incentiveCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"name\": \"calculateLecturePoint\",\"outputs\": [{\"name\": \"averagePoint\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"getLectureCount\",\"outputs\": [{\"name\": \"lectureCount\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureID\",\"outputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"name\": \"getLectureTotalCost\",\"outputs\": [{\"name\": \"totalLectureCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"name\": \"getLectureVote\",\"outputs\": [{\"name\": \"voteCount\",\"type\": \"uint256\"},{\"name\": \"preparation_point\",\"type\": \"uint256\"},{\"name\": \"content_point\",\"type\": \"uint256\"},{\"name\": \"proceed_point\",\"type\": \"uint256\"},{\"name\": \"communication_point\",\"type\": \"uint256\"},{\"name\": \"satisfaction_point\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"_studentAddress\",\"type\": \"address\"}],\"name\": \"getStudentIndexNumber\",\"outputs\": [{\"name\": \"studentIndex\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lectureIDs\",\"outputs\": [{\"name\": \"\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"owner\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"}]"
    
}
