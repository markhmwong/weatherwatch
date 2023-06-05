//
//  TestUserConfiguration.swift
//  WeatherWatch - Time and WeatherTests
//
//  Created by Mark Wong on 3/6/2023.
//

import XCTest
@testable import WeatherWatch___Time_and_Weather

final class TestUserConfiguration: XCTestCase {

    let userConfiguration: UserConfiguration = UserConfiguration.shared
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSavedSpeechTrigger() {
        let st = SpeechTrigger.everySecond
        userConfiguration.updateSpeechTrigger(speechTrigger: st)
        let uc = userConfiguration.getSpeechTrigger()
        XCTAssertEqual(uc, st)
    }
    
    func testDefaults() {
        let uc = userConfiguration
        uc.resetToDefaults()
        let speechTrigger = uc.getSpeechTrigger()
        XCTAssertEqual(speechTrigger, SpeechTrigger.off)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
