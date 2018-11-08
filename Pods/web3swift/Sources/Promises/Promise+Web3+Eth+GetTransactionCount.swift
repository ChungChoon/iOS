//
//  Promise+Web3+Eth+GetTransactionCount.swift
//  web3swift
//
//  Created by Alexander Vlasov on 17.06.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import BigInt
import Foundation
import PromiseKit

extension Web3.Eth {
    public func getTransactionCountPromise(address: Address, onBlock: String = "latest") -> Promise<BigUInt> {
        let addr = address.address
        return getTransactionCountPromise(address: addr, onBlock: onBlock)
    }

    public func getTransactionCountPromise(address: String, onBlock: String = "latest") -> Promise<BigUInt> {
        let request = JsonRpcRequestFabric.prepareRequest(.getTransactionCount, parameters: [address.lowercased(), onBlock])
        let rp = web3.dispatch(request)
        let queue = web3.requestDispatcher.queue
        return rp.map(on: queue) { response in
            guard let value: BigUInt = response.getValue() else {
                if response.error != nil {
                    throw Web3Error.nodeError(response.error!.message)
                }
                throw Web3Error.nodeError("Invalid value from Ethereum node")
            }
            return value
        }
    }
}
