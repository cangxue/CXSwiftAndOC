//
//  CXFacade.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/21.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

//警报器
class AlarmSensor: NSObject {
    func run() {
        print("Alarm Ring...")
    }
}
//喷水器
class WaterSprinker: NSObject {
    func run() {
        print("Spray Water...")
    }
}
//自动拨号器
class EmergencyDialer: NSObject {
    func run() {
        print("Dial 119...")
    }
}

//门面
class CXFacade: NSObject {
    let alarm_sensor = AlarmSensor()
    let water_sprinker = WaterSprinker()
    let emergency_dialer = EmergencyDialer()
    
    func runAll() {
        self.alarm_sensor.run()
        self.water_sprinker.run()
        self.emergency_dialer.run()
    }
    
}
