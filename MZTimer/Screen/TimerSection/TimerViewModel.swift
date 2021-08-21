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

    private var mTimer : Timer?
    private var passedTimeSeconds = 0
    @Published var isPaused: Bool = false {
        didSet {
            UserDefaults.standard.setValue(isPaused, forKey: "isPaused")
        }
    }

    private var currentCategory: Category = Category(emoji: "", title: "")
    private let timeInterval : TimeInterval = 1
    private var startDate: Date?
    private var fromBackground: Bool = false

    override init() {
        super.init()
        //unexpected termination
        NotificationCenter.default.addObserver(forName: UIApplication.willTerminateNotification, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            // 타이머 진행 중일 때 앱이 꺼지면 현재 이벤트를 임시저장 한다.
            self.fromBackground = false
            if self.getTimerStatus() {
                self.tempSave(event:Event(emoji: self.currentCategory.emoji, title: self.currentCategory.title, time: self.passedTimeSeconds, startDate: self.startDate ?? Date()))
            }
        }

        NotificationCenter.default.addObserver(forName: UIApplication.willEnterForegroundNotification, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            print("현재 앱 상태 타이머 진행중 \(self.getTimerStatus()) \(self.getTempEvent()) \(self.getIsPaused())")


            if self.getTimerStatus() { // 타이머 진행 중일 때 Foregorund
                let event = self.getTempEvent()
                NotificationCenter.default.post(name: .AppEnterForeground, object: nil, userInfo: ["event":event as Any] )
                if self.getIsPaused() { // 타이머 paused 일 때 Foregorund
                    self.passedTimeSeconds = event?.time ?? 0
                    self.timerCallback()
                    self.isPaused = true
                } else { // 타이머 진행 중일 때 Foregorund
                    let passedTime =  Int(Date().timeIntervalSince(event?.startDate ?? Date()))
                    print("지난 시간 \(passedTime)")
                    self.passedTimeSeconds = passedTime
                    self.isPaused = false
                    if self.fromBackground { // 타이머 진행 중일 때 Background -> Foregorund

                    } else { // terminated -> foregound 경우
                        self.addTimer()
                        self.timerCallback()
                    }
                }

            }
        }

        NotificationCenter.default.addObserver(forName: UIApplication.didEnterBackgroundNotification, object: nil, queue: .main) { [weak self] _ in
            guard let `self` = self else { return }
            // 타이머 진행중일 때 Background 들어가면
            self.fromBackground = true
            if self.getTimerStatus() {
                self.tempSave(event:Event(emoji: self.currentCategory.emoji, title: self.currentCategory.title, time: self.passedTimeSeconds, startDate: self.startDate ?? Date()))
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
        }else{
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
