//
//  TestClock.swift
//  WeatherWatch - Time and WeatherTests
//
//  Created by Mark Wong on 8/6/2023.
//

import XCTest
@testable import WeatherWatch___Time_and_Weather

final class TestClock: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSpeak() {
        let userConfig = UserConfiguration.shared
        let clock = Clock(userConfig: userConfig)
        
        let date = Date()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
