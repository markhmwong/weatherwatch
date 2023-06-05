//
//  MainViewModel.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import Foundation

class MainViewModel: NSObject {
    
    let userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        super.init()
    }
}
