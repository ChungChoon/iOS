//
//  ChungChul_iOSTests.swift
//  ChungChul_iOSTests
//
//  Created by ParkSungJoon on 16/10/2018.
//  Copyright © 2018 Park Sung Joon. All rights reserved.
//

import XCTest
@testable import ChungChul_iOS

class ChungChul_iOSTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCalculateEvaluationAveragePoint() {
        var value: Int?
        let lectureNumber: Int = 0
        do {
            let contractAddress = CaverSingleton.sharedInstance.contractAddress
            value = try contractAddress.call("calculateEvaluationAveragePoint(uint256)", lectureNumber).wait().intCount()
            print(value!)
        } catch{
            print("Get Function Result Fail!")
            print(error.localizedDescription)
        }
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
