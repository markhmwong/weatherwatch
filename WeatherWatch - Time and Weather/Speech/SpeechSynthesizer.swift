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
    
    init() {
        synthesizer = AVSpeechSynthesizer()
    }
    
    func speak(_ text: String, language: String = "en-US") {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: language)
        synthesizer.speak(utterance)
    }
        
    func stopSpeaking() {
        synthesizer.stopSpeaking(at: .immediate)
    }
}
