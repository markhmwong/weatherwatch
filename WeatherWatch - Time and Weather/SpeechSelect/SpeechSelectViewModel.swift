//
//  SpeechSelectViewModel.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import Foundation

class SpeechSelectViewModel: NSObject {

    let speechTriggers: [SpeechTrigger] = SpeechTrigger.allCases

    var selectedTrigger: SpeechTrigger // Initially selected trigger

    var userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        self.selectedTrigger = userConfig.getSpeechTrigger()
        super.init()
    }
    
    func numberOfRows() -> Int {
        return speechTriggers.count
    }

    func trigger(forIndexPath indexPath: IndexPath) -> SpeechTrigger {
        return speechTriggers[indexPath.row]
    }

    func selectTrigger(atIndexPath indexPath: IndexPath) {
        selectedTrigger = speechTriggers[indexPath.row]
    }

    func isSelectedTrigger(atIndexPath indexPath: IndexPath) -> Bool {
        let trigger = speechTriggers[indexPath.row]
        return trigger == selectedTrigger
    }

    func handleSelectedTrigger() {
        // Perform actions based on the selected trigger
        switch selectedTrigger {
        case .off:
            // Handle "off" trigger
            break
        case .everyHour:
            // Handle "everyHour" trigger
            break
        case .everyMinute:
            // Handle "everyMinute" trigger
            break
        // Handle other triggers...
        case .everySecond:
            break
        case .every30Minutes:
            break
        case .every15Minutes:
            break
        case .every10Minutes:
            break
        case .every5Minutes:
            break
        }
    }
}
