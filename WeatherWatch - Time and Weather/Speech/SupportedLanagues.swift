//
//  SupportedLanagues.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 1/6/2023.
//

import AVFoundation

enum SupportedLanguage: String, CaseIterable {
    case englishUS = "en-US"
    case spanishSpain = "es-ES"
    case frenchFrance = "fr-FR"
    case germanGermany = "de-DE"
    case italianItaly = "it-IT"
    case japaneseJapan = "ja-JP"
    case chineseChina = "zh-CN"
    case koreanSouthKorea = "ko-KR"
    case russianRussia = "ru-RU"
    case portugueseBrazil = "pt-BR"

    var localizedDescription: String {
        let locale = Locale(identifier: self.rawValue)
        return locale.localizedString(forIdentifier: self.rawValue) ?? self.rawValue
    }

//    static var allCases: [SupportedLanguage] {
//        return AVSpeechSynthesisVoice.speechVoices().compactMap {
//            SupportedLanguage(rawValue: $0.language)
//        }
//    }
}
