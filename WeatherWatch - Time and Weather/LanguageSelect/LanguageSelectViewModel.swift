//
//  LanguageSelectViewModel.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 11/6/2023.
//

import Foundation

class LanguageSelectViewModel: NSObject {
    private let supportedLanguages: [SupportedLanguage] = SupportedLanguage.allCases
    
    var selectedLanguage: SupportedLanguage? = nil
    
    private let userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        super.init()
        self.initSelection()
    }
    
    var numberOfLanguages: Int {
        return supportedLanguages.count
    }
    
    func initSelection() {
        let l = self.userConfig.getLanguage()
        self.selectedLanguage = l
    }
    
    func language(at index: Int) -> SupportedLanguage {
        return supportedLanguages[index]
    }
    
    func selectLanguage(at index: Int) {
        selectedLanguage = supportedLanguages[index]
    }
    
    func updateConfig() {
        userConfig.updateLanguage(language: self.selectedLanguage ?? .englishUS)
    }
}
