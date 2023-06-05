//
//  Selectable Triggers.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import Foundation

// User can only select one setting
enum SpeechTrigger: String, CaseIterable {
    case off
    case everyHour
    case everyMinute
    case everySecond
    case every30Minutes
    case every15Minutes
    case every10Minutes
    case every5Minutes
}
