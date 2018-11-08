//
//  Promise+Web3+Eth+GetBlockByHash.swift
//  web3swift
//
//  Created by Alexander Vlasov on 17.06.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import BigInt
import Foundation
import PromiseKit

extension Web3.Eth {
    public func getBlockByHashPromise(_ hash: Data, fullTransactions: Bool = false) -> Promise<Block> {
        let hashString = hash.toHexString().withHex
        return getBlockByHashPromise(hashString, fullTransactions: fullTransactions)
    }

    public func getBlockByHashPromise(_ hash: String, fullTransactions: Bool = false) -> Promise<Block> {
        let request = JsonRpcRequestFabric.prepareRequest(.getBlockByHash, parameters: [hash, fullTransactions])
        let rp = web3.dispatch(request)
        let queue = web3.requestDispatcher.queue
        return rp.map(on: queue) { response in
            guard let value: Block = response.getValue() else {
                if response.error != nil {
                    throw Web3Error.nodeError(response.error!.message)
                }
                throw Web3Error.nodeError("Invalid value from Ethereum node")
            }
            return value
        }
    }
}
