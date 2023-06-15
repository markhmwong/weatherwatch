//
//  CoordinatorProtocol.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 10/6/2023.
//

import UIKit

protocol Coordinator {
    var navigation: UINavigationController { get }
    func start()
    func stop()
}
