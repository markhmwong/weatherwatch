//
//  MainCoordinator.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    let userConfig = UserConfiguration()
    
    var navigation: UINavigationController
    
    var rootViewController: MainViewController! = nil
        
    init(navigation: UINavigationController) {
        self.navigation = navigation
        super.init()
    }
    
    func start() {
        let vm = MainViewModel(userConfig: userConfig)
        self.rootViewController = MainViewController(viewModel: vm, coordinator: self)
        self.navigation.pushViewController(rootViewController, animated: false)
    }
    
    func stop() {
        // do nothing
    }
    
    @objc func handleShowSettings() {
        let coordinator = SettingsCoordinator(navigation: self.navigation, userConfig: userConfig)
        coordinator.start()
    }

}
