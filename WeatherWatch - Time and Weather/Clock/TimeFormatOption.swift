//
//  TimeFormatOption.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import Foundation

enum TimeFormatOption: String, CaseIterable {
    case hourMinuteSecond
    case hourMinuteSecondMillisecond

    var dateFormat: String {
        switch self {
        case .hourMinuteSecond:
            return "HH:mm:ss"
        case .hourMinuteSecondMillisecond:
            return "HH:mm:ss.SSS"
        }
    }
    
    var formatName: String {
        switch self {
        case .hourMinuteSecond:
            return "Standard"
        case .hourMinuteSecondMillisecond:
            return "Sport"
        }
    }
}
