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
    }
    
    let keychain: KeychainSwift = KeychainSwift()
    
    static var shared: UserConfiguration = UserConfiguration()
    
    override init() {
        super.init()
        initConfigurationKeysToDefaults()
    }
    
    private func initConfigurationKeysToDefaults() {
        let ck = ConfigurationKeys.speechTrigger.rawValue
        if self.keychain.get(ck) == nil {
            self.keychain.set("off", forKey: ck)
        }
    }
    
    func resetToDefaults() {
        let ck = ConfigurationKeys.speechTrigger.rawValue
        keychain.set("off", forKey: ck)
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
}
