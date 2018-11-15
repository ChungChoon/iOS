//
//  ChungChul_iOSTests.swift
//  ChungChul_iOSTests
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import XCTest
import web3swift
import BigInt
@testable import ChungChul_iOS

class ChungChul_iOSTests: XCTestCase {
    
    override func setUp() {
        CaverSingleton.setUserAddress(Address("0xf694888fc6eea44f8cd03e9c5f18af8f61bdebe8"))
    }

    //
    func testCalculateEvaluationAveragePoint() {
        var value: Int?
        let lectureNumber: Int = 0
        DispatchQueue.global(qos: .utility).async {
            do {
                let contractAddress = CaverSingleton.sharedInstance.contractAddress
                value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber).wait().intCount()
                print(value!)
            } catch{
                print("Get Function Result Fail!")
                print(error.localizedDescription)
            }
        }
    }
    
    func testGetKlayBalances(){
        let caver = CaverSingleton.sharedInstance.caver
        let userAddress = CaverSingleton.sharedInstance.userAddress
        let keystore = CaverSingleton.sharedInstance.keystoreMangaerInDevice()
        var userKlay: BigUInt = 0
        var privateKey: Data?
        DispatchQueue.global(qos: .utility).async {
            do{
                userKlay = try caver.eth.getBalance(address: userAddress)
                privateKey = try keystore?.UNSAFE_getPrivateKeyData(password: "doa01092", account: userAddress)
                print(userKlay)
                print(privateKey?.toHexString())
            }catch{
                print("Get Klay Balance Fail")
            }
        }
    }
    
    func testPurchaseLecture(){
        let caver = CaverSingleton.sharedInstance.caver
        let ABI = CaverSingleton.sharedInstance.contractABI
        let contractAddress = CaverSingleton.sharedInstance.contractAddress
        let passwd = "doa01092"
        let lecturePrice = 10
        let lectureNumber = BigUInt(0)
        DispatchQueue.global(qos: .utility).async {
            do {
                // Option Setting
                var options = Web3Options.default
                options.value = Web3.Utils.parseToBigUInt("\(lecturePrice)", units: .eth)
                options.gasLimit = BigUInt(701431)
                options.from = CaverSingleton.sharedInstance.userAddress
                
                // Parameter Setting
                let lectureNumberParameter = [lectureNumber] as [AnyObject]
                
                // Estimated Gas
                let estimatedGas = try caver.contract(ABI, at: contractAddress).method("purchaseLecture", parameters: lectureNumberParameter, options: options).estimateGas(options: nil)
                options.gasLimit = estimatedGas
                
                // Transaction Setting
                let transactionResult = try caver.contract(ABI, at: contractAddress).method("purchaseLecture", parameters: lectureNumberParameter, options: options)
                
                // Transaction Send
                let sendingResult = try transactionResult.send(password: passwd)
                print(sendingResult.transaction)
            } catch{
                print("You don't have enough KLAY!")
                print(error.localizedDescription)
            }
        }
    }
}
