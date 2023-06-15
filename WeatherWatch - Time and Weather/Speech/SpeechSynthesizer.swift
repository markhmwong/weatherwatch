//
//  SpeechSynthesizer.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 1/6/2023.
//

import UIKit
import AVFoundation

class TextToSpeech {
    let synthesizer: AVSpeechSynthesizer
    private let userConfig: UserConfiguration
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        synthesizer = AVSpeechSynthesizer()
    }
    
    func speak(_ text: String, language: String = "en-US") {
        let utterance = AVSpeechUtterance(string: text)
        let l = self.userConfig.getLanguage()
        utterance.voice = AVSpeechSynthesisVoice(language: l.rawValue)
        synthesizer.speak(utterance)
    }
        
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
