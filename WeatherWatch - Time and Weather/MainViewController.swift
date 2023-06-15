//
//  ViewController.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 1/6/2023.
//

import UIKit
import KeychainSwift
import WeatherKit
import CoreLocation

class MainViewController: UIViewController, CLLocationManagerDelegate {

    var clock: Clock! = nil
    
    let ratio = UIScreen.main.nativeBounds.height / UIScreen.main.nativeBounds.width

    lazy var clockView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var timeLabel: UILabel = {
        let label = UILabel()
        // Specify your desired font and style
        let font = UIFont.systemFont(ofSize: 20.0)

        // Create a UIFontMetrics instance
        let fontMetrics = UIFontMetrics(forTextStyle: .body)

        // Calculate new font size based on available space or design requirements
        let isPortrait = traitCollection.verticalSizeClass == .regular
        let fontSize: CGFloat = 80.0 // portraint size
        let maximumFontSize: CGFloat = isPortrait ? fontSize : fontSize * ratio

        // Calculate the scaled font size with a maximum limit
        let scaledFontSize = min(fontMetrics.scaledValue(for: maximumFontSize), maximumFontSize)

        // Create a new font with the scaled font size
        let scaledFont = font.withSize(scaledFontSize)

        // Assign the scaled font to the label
        label.font = scaledFont
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "10:24"
        label.textAlignment = .center
//        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    
    // DEBUGGING purposes
    
    lazy var debuggingLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .caption1)
        label.textColor = .black
        label.numberOfLines = 0
        label.text = "\(viewModel.userConfig.getSpeechTrigger().rawValue)\n\(viewModel.userConfig.getTimeFormat().dateFormat)"
        return label
    }()
    
    var viewModel: MainViewModel
    
    var coordinator: MainCoordinator
    
    var weatherService: WeatherService = WeatherService()
    
    var location: CLLocationManager! = nil
    
    init(viewModel: MainViewModel, coordinator: Coordinator) {
        self.viewModel = viewModel
        self.coordinator = coordinator as! MainCoordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    override func loadView() {
        super.loadView()
        setupViews()
        initialiseClock()
        Task {
            location = CLLocationManager()
            location.requestWhenInUseAuthorization()
            location.delegate = self
            location.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let rightItem = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(handleShowSettings))
        self.navigationItem.rightBarButtonItem = rightItem
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initialiseClock() {
        // setup timeformat from user settings
        let tf = viewModel.userConfig.getTimeFormat()
        clock = Clock(timeFormatOption: tf, userConfig: viewModel.userConfig)
        clock.onUpdate = { [weak self] formattedTime in
            self?.timeLabel.text = formattedTime
        }
        clock.start()
    }

    private func setupViews() {
        view.backgroundColor = .cyan
        
        
        // clock
        // The view and the clock label
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
        
        view.addSubview(debuggingLabel)
        
        debuggingLabel.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        debuggingLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        clock.start()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        clock.stop()
    }
    
    @objc func handleShowSettings() {
        coordinator.handleShowSettings()
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)

        // Check if the user interface style or size class has changed
        if traitCollection.verticalSizeClass != previousTraitCollection?.verticalSizeClass {
            updateFontSize()
        }
    }

    func updateFontSize() {
        let fontMetrics = UIFontMetrics(forTextStyle: .body)

        // Calculate new font size based on available space or design requirements
        let isPortrait = traitCollection.verticalSizeClass == .regular
        let fontSize: CGFloat = 80.0
        let maximumFontSize: CGFloat = isPortrait ? fontSize : fontSize * ratio
        let scaledFontSize = min(fontMetrics.scaledValue(for: maximumFontSize), maximumFontSize)

        // Create a new font with the updated size
        let scaledFont = UIFont.systemFont(ofSize: scaledFontSize)

        // Apply the new font size to your UILabel or relevant UI elements
        timeLabel.font = scaledFont
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let l = locations.first else { return }
        self.location.stopUpdatingLocation()
        self.getWeather(location: l)
    }

    func getWeather(location: CLLocation) {
        Task {
            do {
                let result = try await self.weatherService.weather(for: location)
                print("current hourly forecast \(result.dailyForecast)")
            } catch {
                print("No weather retrieved")
            }

        }
        
    }
    
    deinit {
        #if DEBUG
        print("Main View Controller Deinit")
        #endif
    }
}


