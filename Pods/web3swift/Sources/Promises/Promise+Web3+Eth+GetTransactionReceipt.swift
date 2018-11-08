//
//  Promise+Web3+Eth+GetTransactionReceipt.swift
//  web3swift
//
//  Created by Alexander Vlasov on 17.06.2018.
//  Copyright © 2018 Bankex Foundation. All rights reserved.
//

import BigInt
import Foundation
import PromiseKit

extension Web3.Eth {
    public func getTransactionReceiptPromise(_ txhash: Data) -> Promise<TransactionReceipt> {
        let hashString = txhash.toHexString().withHex
        return getTransactionReceiptPromise(hashString)
    }

    public func getTransactionReceiptPromise(_ txhash: String) -> Promise<TransactionReceipt> {
        let request = JsonRpcRequestFabric.prepareRequest(.getTransactionReceipt, parameters: [txhash])
        let rp = web3.dispatch(request)
        let queue = web3.requestDispatcher.queue
        return rp.map(on: queue) { response in
            guard let value: TransactionReceipt = response.getValue() else {
                if response.error != nil {
                    throw Web3Error.nodeError(response.error!.message)
                }
                throw Web3Error.nodeError("Invalid value from Ethereum node")
            }
            return value
        }
    }
}
