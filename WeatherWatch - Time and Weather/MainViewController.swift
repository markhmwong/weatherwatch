//
//  ViewController.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 1/6/2023.
//

import UIKit
import KeychainSwift

class MainViewController: UIViewController {

    var clock: Clock! = nil
    
    lazy var clockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10:24"
        label.textAlignment = .center
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    var viewModel: MainViewModel
    
    override func loadView() {
        super.loadView()
        setupViews()
        initialiseClock()
        
        // Do any additional setup after loading the view.
    }
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialiseClock() {
        // setup timeformat from user settings
        clock = Clock()
        clock.onUpdate = { [weak self] formattedTime in
            self?.timeLabel.text = formattedTime
        }
        clock.start()
    }

    private func setupViews() {
        view.backgroundColor = .cyan
        view.addSubview(clockView)
        
        clockView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        clockView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        clockView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        clockView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        
        clockView.addSubview(timeLabel)
        
        timeLabel.topAnchor.constraint(equalTo: clockView.topAnchor).isActive = true
        timeLabel.bottomAnchor.constraint(equalTo: clockView.bottomAnchor).isActive = true
        timeLabel.leadingAnchor.constraint(equalTo: clockView.leadingAnchor).isActive = true
        timeLabel.trailingAnchor.constraint(equalTo: clockView.trailingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clock.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clock.stop()
    }
    
    deinit {
        #if DEBUG
        print("Main View Controller Deinit")
        #endif
    }
}

class MainViewModel: NSObject {
    
    let userConfig: UserConfiguration
    
    init(userConfig: UserConfiguration) {
        self.userConfig = userConfig
        super.init()
    }
}
