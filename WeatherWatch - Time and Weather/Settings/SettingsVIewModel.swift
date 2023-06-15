//
//  SettingsVIewModel.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 9/6/2023.
//

import UIKit

struct Option {
    let title: String
    let action: (SettingsCoordinator) -> Void
    let section: Int
}

enum SettingsSection: Int {
    case general
    case tip
}

class SettingsViewModel: NSObject {
    private lazy var options: [Option] = [
        Option(title: "Select Speech Language", action: { [weak self] sc in
            // handle language selection
            self?.selectSpeechLanguage(sc: sc)
        }, section: SettingsSection.general.rawValue),
        Option(title: "Select Trigger Interval", action: { [weak self] sc in
            // Handle trigger interval selection
            self?.selectSpeechTrigger(sc: sc)
        }, section: SettingsSection.general.rawValue),
        Option(title: "Change Time Formatting", action:{ [weak self] sc in
            // Handle time format change
            self?.selectTimeFormatting(sc: sc)
        }, section: SettingsSection.general.rawValue),
        Option(title: "Tip the Developer", action: { [weak self] sc in
            // Handle tipping the developer
            self?.selectTip(sc: sc)
        }, section: SettingsSection.tip.rawValue)
    ]
    
    let userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        super.init()
    }
    
    func numberOfSections() -> Int {
        return options.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        let sectionEnum = SettingsSection(rawValue: section)
        return options.filter { $0.section == sectionEnum?.rawValue }.count
        
    }
    
    func optionTitle(at indexPath: IndexPath) -> String {
        let sectionEnum = SettingsSection(rawValue: indexPath.section)
        let sectionOptions = options.filter { $0.section == sectionEnum?.rawValue }
        return sectionOptions[indexPath.row].title
    }
    
    func handleSelection(at indexPath: IndexPath, coordinator: Coordinator) {
        let sc = coordinator as! SettingsCoordinator
        let sectionEnum = SettingsSection(rawValue: indexPath.section)
        let sectionOptions = options.filter { $0.section == sectionEnum?.rawValue }
        sectionOptions[indexPath.row].action(sc)
    }
    
    private func selectSpeechTrigger(sc : SettingsCoordinator) {
        print("speech trigger")
        sc.showSpeechTrigger()
    }
    
    private func selectSpeechLanguage(sc: SettingsCoordinator) {
        sc.showSpeechLanaguage()
    }
    
    private func selectTimeFormatting(sc: SettingsCoordinator) {
        sc.showTimeFormatting()
    }
    
    private func selectTip(sc: SettingsCoordinator) {
        sc.showTip()
    }
}
