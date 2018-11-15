//
//  KeystoreSingleton.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 04/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import web3swift

final class CaverSingleton {
    
    static let sharedInstance: CaverSingleton = CaverSingleton()
    
    private init(){
        Web3.default = .init(provider: Web3HttpProvider.init(URL(string: "http://localhost:8551")!)!)
        guard let setupUserAddress = CaverSingleton.user.address else {
            fatalError("Error - you must call setup before accessing CaverSingleton.sharedInstance")
        }
        userAddress = setupUserAddress
    }
    
    private class User {
        var address: Address?
    }
    
    private static let user = User()
    
    class func setUserAddress(_ userAddress: Address){
        CaverSingleton.user.address = userAddress
    }
    
    let caver: Web3 = Web3(url: URL(string: "http://localhost:8551")!)!
    let contractAddress = Address("0x96a277b958988d9b4207dda53067fbd787b0e2db")
    let userAddress: Address
    
    func keystoreMangaerInDevice() -> KeystoreManager?{
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore"
        let keystoreManager =  KeystoreManager.managerForPath(path)
        return keystoreManager
    }
    
    let contractABI = "[{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"acceptAdmin\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"createLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"_preparation_point\",\"type\": \"uint256\"},{\"name\": \"_content_point\",\"type\": \"uint256\"},{\"name\": \"_proceed_point\",\"type\": \"uint256\"},{\"name\": \"_communication_point\",\"type\": \"uint256\"},{\"name\": \"_satisfaction_point\",\"type\": \"uint256\"}],\"name\": \"evaluateLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"payBalance\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"purchaseLecture\",\"outputs\": [],\"payable\": true,\"stateMutability\": \"payable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"recreateLecture\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"constant\": false,\"inputs\": [{\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"transferOwnership\",\"outputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"function\"},{\"inputs\": [],\"payable\": false,\"stateMutability\": \"nonpayable\",\"type\": \"constructor\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"id\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"teacher\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"lectureCost\",\"type\": \"uint256\"}],\"name\": \"CreatingLecture\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"lectureID\",\"type\": \"bytes32\"},{\"indexed\": true,\"name\": \"evaluater\",\"type\": \"address\"},{\"indexed\": false,\"name\": \"evaluatingCount\",\"type\": \"uint256\"}],\"name\": \"EvaluatingLecture\",\"type\": \"event\"},{\"anonymous\": false,\"inputs\": [{\"indexed\": true,\"name\": \"previousOwner\",\"type\": \"address\"},{\"indexed\": true,\"name\": \"newOwner\",\"type\": \"address\"}],\"name\": \"OwnershipTransferred\",\"type\": \"event\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"calculateEvaluationAveragePoint\",\"outputs\": [{\"name\": \"averagePoint\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureFee\",\"type\": \"uint256\"},{\"name\": \"percent\",\"type\": \"uint256\"}],\"name\": \"calculateIncentiveCost\",\"outputs\": [{\"name\": \"incentiveCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureEvaluationPoint\",\"outputs\": [{\"name\": \"evaluationCount\",\"type\": \"uint256\"},{\"name\": \"preparation_point\",\"type\": \"uint256\"},{\"name\": \"content_point\",\"type\": \"uint256\"},{\"name\": \"proceed_point\",\"type\": \"uint256\"},{\"name\": \"communication_point\",\"type\": \"uint256\"},{\"name\": \"satisfaction_point\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureID\",\"outputs\": [{\"name\": \"lectureID\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"}],\"name\": \"getLectureTotalCost\",\"outputs\": [{\"name\": \"totalLectureCost\",\"type\": \"uint256\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"lectureNumber\",\"type\": \"uint256\"},{\"name\": \"studentAddress\",\"type\": \"address\"}],\"name\": \"isValidStudent\",\"outputs\": [{\"name\": \"isValid\",\"type\": \"bool\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [{\"name\": \"\",\"type\": \"uint256\"}],\"name\": \"lectureIDs\",\"outputs\": [{\"name\": \"\",\"type\": \"bytes32\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"},{\"constant\": true,\"inputs\": [],\"name\": \"owner\",\"outputs\": [{\"name\": \"\",\"type\": \"address\"}],\"payable\": false,\"stateMutability\": \"view\",\"type\": \"function\"}]"
}