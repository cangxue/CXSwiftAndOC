//
//  CXObserver.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/29.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

/********* 观察者 *******/
class CXObserver: NSObject {
    func update(action: String) {
        return
    }
}
//报警器
class CXAlarmSensor: CXObserver {
    override func update(action: String) {
        print("Alarm Got: \(action)")
        self.runAlarm()
    }
    
    func runAlarm() {
        print("Alarm Ring...")
    }
}
//洒水器
class CXWaterSprinker: CXObserver {
    override func update(action: String) {
        print("Sprinker Got: \(action)")
        self.runSprinker()
    }
    func runSprinker() {
        print("Spray Water...")
    }
}
//拨号器
class CXEmergencyDialer: CXObserver {
    override func update(action: String) {
        print("Dialer Got: \(action)")
        self.runDialer()
    }
    func runDialer() {
        print("Dial 119...")
    }
}
/********* 被观察者 *******/
class CXObserved: NSObject {
    var observers: [CXObserver] = []
    var action = ""
    func addObserver(observer: CXObserver) {
        self.observers.append(observer)
    }
    func notifyAll() {
        for obs in observers {
            obs.update(action: self.action)
        }
    }
}
class CXSmokeSensor: CXObserved {
    func isFire() -> Bool {
        return true
    }
}
