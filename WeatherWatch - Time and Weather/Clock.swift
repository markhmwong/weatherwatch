//
//  Clock.swift
//  WeatherWatch - Time and Weather
//
//  Created by Mark Wong on 1/6/2023.
//

import UIKit

class Clock {
    var displayLink: CADisplayLink?
    var onUpdate: ((String) -> Void)?
    var textToSpeech: TextToSpeech?
    var timeFormatOption: TimeFormatOption?
    
    init(timeFormatOption: TimeFormatOption = .hourMinuteSecond) {
        self.timeFormatOption = timeFormatOption
        textToSpeech = TextToSpeech()
    }
    
    func start() {
        displayLink = CADisplayLink(target: self, selector: #selector(updateTime))
        displayLink?.preferredFramesPerSecond = 60
        displayLink?.add(to: .current, forMode: RunLoop.Mode.default)
        updateTime()
    }
    
    func stop() {
        displayLink?.invalidate()
        displayLink = nil
        textToSpeech?.stopSpeaking()
    }
    
    func formatTime(_ time: Date, timeFormatOption: TimeFormatOption) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = timeFormatOption.dateFormat
        return formatter.string(from: time)
    }
    
    @objc func updateTime() {
        let currentTime = Date()
        guard let tfo = timeFormatOption else { return }
        let formattedTime = formatTime(currentTime, timeFormatOption: tfo)
        onUpdate?(formattedTime)
        
        // Speak every hour
        if Calendar.current.component(.minute, from: currentTime) == 0 {
            let hourText = "\(Calendar.current.component(.hour, from: currentTime)) o'clock"
            textToSpeech?.speak(hourText)
        }
        
        // Speak every minute
        let minuteText = "\(Calendar.current.component(.minute, from: currentTime)) minutes"
        textToSpeech?.speak(minuteText)
    }
    
    deinit {
        #if DEBUG
        print("Clock deinit")
        #endif
    }
}

enum TimeFormatOption {
    case hourMinuteSecond
    case hourMinuteSecondMillisecond

    var dateFormat: String {
        switch self {
        case .hourMinuteSecond:
            return "HH:mm:ss"
        case .hourMinuteSecondMillisecond:
            return "HH:mm:ss.SSS"
        }
    }
}

