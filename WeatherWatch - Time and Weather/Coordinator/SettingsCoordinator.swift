//
//  SettingsCoordinator.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 9/6/2023.
//

import UIKit

class SettingsCoordinator: NSObject, Coordinator {
    
    var navigation: UINavigationController
    
    var rootViewController: SettingsViewController! = nil
 
    var userConfig: UserConfiguration
    
    init(navigation: UINavigationController, userConfig: UserConfiguration) {
        self.navigation = navigation
        self.userConfig = userConfig
        super.init()
    }
    
    func start() {
        let vm = SettingsViewModel(userConfig: userConfig)
        self.rootViewController = SettingsViewController(viewModel: vm, coordinator: self)
        let childNav = UINavigationController(rootViewController: self.rootViewController)
        self.navigation.present(childNav, animated: true)
    }
    
    func stop() {
        // do nothing
    }
    
    func showSpeechTrigger() {
        let vm = SpeechSelectViewModel(userConfig: self.userConfig)
        let vc = SpeechSelectViewController(viewModel: vm)
        self.navigation.pushViewController(vc, animated: true)
    }
    
    func showTip() {
        
    }
    
    func showSpeechLanaguage() {
        let vm = LanguageSelectViewModel(userConfig: self.userConfig)
        let vc = LanguageSelectionViewController(viewModel: vm, coordinator: self)
        self.navigation.pushViewController(vc, animated: true)
    }
    
    func showTimeFormatting() {
        let vm = TimeFormatViewModel(userConfig: self.userConfig)
        let vc = TimeFormatSelectionViewController(viewModel: vm, coordinator: self)
        self.navigation.pushViewController(vc, animated: true)
    }
}
