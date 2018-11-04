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
    
    private init(){}
    
    var caver: web3 = Web3.new(URL(string: "http://localhost:8551")!)!
    var keystoreManager: KeystoreManager?
    var klaytnAddress: EthereumAddress?
    
    func addKeystoreOnCaver(_ mail: String){
        let userDir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let path = userDir+"/keystore/\(mail)"
        keystoreManager =  KeystoreManager.managerForPath(path, scanForHDwallets: true, suffix: "json")
        self.caver.addKeystoreManager(self.keystoreManager)
        
    }
    
    func runningKlaytn(_ mail: String){
        
    }
}
