//
//  MainCoordinator.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 5/6/2023.
//

import UIKit

protocol Coordinator {
    func start()
    func stop()
}

class MainCoordinator: NSObject, Coordinator {
    
    let userConfig = UserConfiguration()
    
    func start() {
        let vm = MainViewModel(userConfig: userConfig)
    }
    
    func stop() {
        
    }
    
    
    init(navigation: UINavigationController) {
        super.init()
    }
    
}
