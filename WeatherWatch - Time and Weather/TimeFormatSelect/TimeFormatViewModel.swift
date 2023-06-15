//
//  TimeFormatViewModel.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import Foundation

class TimeFormatViewModel: NSObject {
    private let timeFormatOptions: [TimeFormatOption] = TimeFormatOption.allCases
    
    var selectedTimeFormat: TimeFormatOption? = nil
    
    let userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        super.init()
        self.initSelection()
    }
    
    var numberOfOptions: Int {
        return timeFormatOptions.count
    }
    
    func initSelection() {
        let tf = self.userConfig.getTimeFormat()
        self.selectedTimeFormat = tf
    }
    
    func option(at index: Int) -> TimeFormatOption {
        return timeFormatOptions[index]
    }
    
    func selectTimeFormat(at index: Int) {
        selectedTimeFormat = timeFormatOptions[index]
    }
    
    func updateConfig() {
        self.userConfig.updateTimeFormat(tf: selectedTimeFormat ?? .hourMinuteSecond)
    }
}
