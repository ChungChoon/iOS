//
//  Keychain.swift
//  ChungChul_iOS
//
//  Created by ParkSungJoon on 19/11/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import UIKit
import Security

class Keychain {
    
    // Save at the Keychain
    class func save(key: String, keystoreData: Data) -> Bool {
        let query = [
            kSecClass as String : kSecClassGenericPassword as String,
            kSecAttrAccount as String : key,
            kSecValueData as String : keystoreData
        ] as [String : Any]
        
        SecItemDelete(query as CFDictionary)
        
        let status: OSStatus = SecItemAdd(query as CFDictionary, nil)
        return status == noErr
    }
    
    // Load at the Keychain
    class func load(key: String) -> Data? {
        let query = [
            kSecClass as String : kSecClassGenericPassword,
            kSecAttrAccount as String : key,
            kSecReturnData as String : kCFBooleanTrue,
            kSecMatchLimit as String : kSecMatchLimitOne
        ] as [String : Any]
        
        var dataTypeRef: AnyObject?
        let status = withUnsafeMutablePointer(to: &dataTypeRef) { (SecItemCopyMatching(query as CFDictionary, UnsafeMutablePointer($0))) }
        
        if status == errSecSuccess {
            if let data = dataTypeRef as! Data? {
                return data
            }
        }
        return nil
    }
}
