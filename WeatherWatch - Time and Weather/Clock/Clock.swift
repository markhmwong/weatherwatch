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
    
    var isHourSpeechSpoken = false
    var isMinuteSpeechSpoken = false
    
    var userConfig: UserConfiguration
    
    init(timeFormatOption: TimeFormatOption = .hourMinuteSecond, userConfig: UserConfiguration) {
        self.timeFormatOption = timeFormatOption
        self.userConfig = userConfig
        textToSpeech = TextToSpeech(userConfig: self.userConfig)
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
        speak(time: currentTime)

    }
    
    func speak(time currentTime: Date) {
        var st = userConfig.getSpeechTrigger()
        
        #if DEBUG
        st = .everyMinute
        #endif
        
        switch st {
        case .off:
            break
        case .everySecond:
            break
        case .everyMinute:
            speakEveryMinute(time: currentTime)
        case .everyHour:
            speakHourly(time: currentTime)
        case .every5Minutes:
            speakEveryInterval(time: currentTime, interval: 5)
        case .every10Minutes:
            speakEveryInterval(time: currentTime, interval: 10)
        case .every15Minutes:
            speakEveryInterval(time: currentTime, interval: 15)
        case .every30Minutes:
            speakEveryInterval(time: currentTime, interval: 30)
        }
    }
    
    // every minute interval
    func speakEveryInterval(time currentTime: Date, interval: Int = 0) {
        // Speak every hour when the minute equals 0
        if Calendar.current.component(.minute, from: currentTime) % interval == 0 {
            if !isHourSpeechSpoken {
                let hourText = "\(Calendar.current.component(.hour, from: currentTime)) o'clock"
                textToSpeech?.speak(hourText)
                isHourSpeechSpoken = true
            }
        } else {
            isHourSpeechSpoken = false
        }
    }
    
    func speakHourly(time currentTime: Date) {
        // Speak every hour when the minute equals 0
        if Calendar.current.component(.minute, from: currentTime) == 0 {
            if !isHourSpeechSpoken {
                let hourText = "\(Calendar.current.component(.hour, from: currentTime)) o'clock"
                textToSpeech?.speak(hourText)
                isHourSpeechSpoken = true
            }
        } else {
            isHourSpeechSpoken = false
        }
    }
    
    func speakEveryMinute(time currentTime: Date) {
        // Speak every minute when the seconds equals 0
        if Calendar.current.component(.second, from: currentTime) == 0 {
            if !isMinuteSpeechSpoken {
                let minuteText = "\(Calendar.current.component(.minute, from: currentTime)) minutes"
                textToSpeech?.speak(minuteText)
                isMinuteSpeechSpoken = true
            }
        } else {
            isMinuteSpeechSpoken = false
        }
    }
    
    deinit {
        #if DEBUG
        print("Clock deinit")
        #endif
    }
}



