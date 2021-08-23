//
//  TimerViewModel.swift
//  MZTimer
//
//  Created by TaeHyeongKim on 2021/06/13.
//

import Foundation
import UIKit
import SwiftUI

class TimerViewModel: NSObject, ObservableObject {

    @Published var seconds : String = "00"
    @Published var minutes: String = "00"
    @Published var hours: String = "00"
    
    @Published var isPaused: Bool = false {
        didSet {
            UserDefaults.standard.setValue(isPaused, forKey: "isPaused")
        }
    }

    private var mTimer : Timer?
    private var passedTimeSeconds = 0
    private var currentCategory: Category = Category(emoji: "", title: "")
    private let timeInterval : TimeInterval = 1
    private var startDate: Date?

    override init() {
        super.init()

        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            if self.getTimerStatus() {
                self.tempSave(event:Event(emoji: self.currentCategory.emoji, title: self.currentCategory.title, time: self.passedTimeSeconds, startDate: self.startDate ?? Date()))
            }
        }

        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            if self.getTimerStatus() {
                if self.mTimer == nil {
                    self.addTimer()
                }
                let event = self.getTempEvent()
                self.currentCategory = Category(emoji: event?.emoji ?? "", title: event?.title ?? "")
                self.startDate = event?.startDate
                if self.getIsPaused() {
                    self.isPaused = true
                    self.passedTimeSeconds = event?.time ?? 0
                } else {
                    self.isPaused = false
                    self.passedTimeSeconds = Int(Date().timeIntervalSince(event?.startDate ?? Date()))
                }
                self.calculateTime()
                NotificationCenter.default.post(name: .AppEnterForeground, object: nil, userInfo: ["event":event as Any] )
            }
        }
    }

    public func start(category: Category) {
        startTimer()
        passedTimeSeconds = 0
        isPaused = false
        startDate = Date()
        self.currentCategory = category
        self.addTimer()
    }

    public func pause() {
        if getTimerStatus() {
            isPaused = true
        }
    }

    public func resume() {
        if getTimerStatus() {
            isPaused = false
        }
    }

    public func stop() {
        if let timer = mTimer {
            if(timer.isValid){
                timer.invalidate()
            }
        }
        saveEvent()
        passedTimeSeconds = 0
        calculateTime()
        endTimer()
        startDate = nil
    }

    //타이머가 호출하는 콜백함수
    @objc private func timerCallback(){
        DispatchQueue.main.async { [self] in
            if isPaused == false {
                passedTimeSeconds += 1
                calculateTime()
            }
        }
    }

    private func calculateTime() {
        seconds = String(format: "%02i", (passedTimeSeconds % 3600) % 60 )
        minutes = String(format:"%02i", (passedTimeSeconds % 3600) / 60 )
        hours = String(format: "%02i", (passedTimeSeconds / 3600)  )
    }

    private func saveEvent() {
        let event = Event(emoji: currentCategory.emoji, title: currentCategory.title, time: passedTimeSeconds, endDate: Date())
        UserDefaultStorage.shared.saveEvent(event: event)
    }

    private func addTimer() {
        if let timer = mTimer {
            if !timer.isValid {
                DispatchQueue.global(qos: .background).async { [self] in
                    mTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
                    RunLoop.current.run()
                }
            }
        } else {
            DispatchQueue.global(qos: .background).async { [self] in
                mTimer = Timer.scheduledTimer(timeInterval: timeInterval, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
                RunLoop.current.run()
            }
        }
    }
}
extension TimerViewModel {
    private func getIsPaused() -> Bool {
        return UserDefaults.standard.bool(forKey: "isPaused")

    }
    private func getTimerStatus() -> Bool {
        return UserDefaults.standard.bool(forKey: "isTimerOn")
    }

    private func startTimer() {
        UserDefaults.standard.set(true, forKey: "isTimerOn")
    }

    private func endTimer() {
        UserDefaults.standard.setValue(false, forKey: "isTimerOn")
    }

    private func tempSave(event: Event) {
        UserDefaults.standard.set(try? PropertyListEncoder().encode(event), forKey: "tempEvent")
    }
    private func getTempEvent() -> Event? {
        if let data = UserDefaults.standard.value(forKey: "tempEvent") as? Data {
            return try? PropertyListDecoder().decode(Event.self, from: data)
        }
        return nil
    }
}
