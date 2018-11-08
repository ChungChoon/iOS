//
//  Promise+Web3+Personal+Sign.swift
//  web3swift
//
//  Created by Alexander Vlasov on 18.06.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import BigInt
import Foundation
import PromiseKit

extension Web3.Personal {
    func signPersonalMessagePromise(message: Data, from: Address, password: String = "BANKEXFOUNDATION") -> Promise<Data> {
        let queue = web3.requestDispatcher.queue
        do {
            if web3.provider.attachedKeystoreManager == nil {
                let hexData = message.toHexString().withHex
                let request = JsonRpcRequestFabric.prepareRequest(.personalSign, parameters: [from.address.lowercased(), hexData])
                return web3.dispatch(request).map(on: queue) { response in
                    guard let value: Data = response.getValue() else {
                        if response.error != nil {
                            throw Web3Error.nodeError(response.error!.message)
                        }
                        throw Web3Error.nodeError("Invalid value from Ethereum node")
                    }
                    return value
                }
            }
            let signature = try Web3Signer.signPersonalMessage(message, keystore: web3.provider.attachedKeystoreManager!, account: from, password: password)
            let returnPromise = Promise<Data>.pending()
            queue.async {
                returnPromise.resolver.fulfill(signature)
            }
            return returnPromise.promise
        } catch {
            let returnPromise = Promise<Data>.pending()
            queue.async {
                returnPromise.resolver.reject(error)
            }
            return returnPromise.promise
        }
    }
}
