//
//  UserConfiguration.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 3/6/2023.
//

import KeychainSwift
import Foundation

class UserConfiguration: NSObject {
    
    enum ConfigurationKeys: String, CaseIterable {
        case speechTrigger
        case timeFormat
        case language
    }
    
    let keychain: KeychainSwift = KeychainSwift()
    
    static var shared: UserConfiguration = UserConfiguration()
    
    override init() {
        super.init()
        initConfigurationKeysToDefaults()
    }
    
    private func initConfigurationKeysToDefaults() {
        resetToDefaults()
    }
    
    func resetToDefaults() {
        defaultSpeechTrigger()
        defaultTimeFormat()
    }
    
    private func defaultSpeechTrigger() {
        let ck = ConfigurationKeys.speechTrigger.rawValue
        keychain.set("off", forKey: ck)
    }
    
    private func defaultTimeFormat() {
        let tf = ConfigurationKeys.timeFormat.rawValue
        self.keychain.set(TimeFormatOption.hourMinuteSecond.rawValue, forKey: tf)
    }
    
    func updateSpeechTrigger(speechTrigger: SpeechTrigger) {
        keychain.set(speechTrigger.rawValue, forKey: ConfigurationKeys.speechTrigger.rawValue)
    }
    
    func getSpeechTrigger() -> SpeechTrigger {
        guard let trigger = keychain.get(ConfigurationKeys.speechTrigger.rawValue) else {
            return SpeechTrigger.off
        }
        
        return SpeechTrigger.init(rawValue: trigger) ?? .off
    }
    
    func updateTimeFormat(tf: TimeFormatOption) {
        keychain.set(tf.rawValue, forKey: ConfigurationKeys.timeFormat.rawValue)
    }
    
    func getTimeFormat() -> TimeFormatOption {
        guard let timeFormat = keychain.get(ConfigurationKeys.timeFormat.rawValue) else {
            return TimeFormatOption.hourMinuteSecond
        }
        
        return TimeFormatOption.init(rawValue: timeFormat) ?? .hourMinuteSecond
    }
    
    func getLanguage() -> SupportedLanguage {
        let l = keychain.get(ConfigurationKeys.language.rawValue) ?? SupportedLanguage.englishUS.rawValue
        return SupportedLanguage(rawValue: l) ?? .englishUS
    }
    
    func updateLanguage(language: SupportedLanguage) {
        keychain.set(language.rawValue, forKey: ConfigurationKeys.language.rawValue)
    }
}
