//
//  CXState.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/29.
//  Copyright © 2017年 CX. All rights reserved.
//
//  状态模式

import UIKit

//抽象状态类
class LiftState: NSObject {
    func open() -> LiftState {
        return LiftState()
    }
    func close() -> LiftState {
        return LiftState()
    }
    func run() -> LiftState {
        return LiftState()
    }
    func stop() -> LiftState {
        return LiftState()
    }
}
//具体状态类
class OpenState: LiftState {
    override func open() -> LiftState {
        print("OPEN: The door is opened")
        return self
    }
    override func close() -> LiftState {
        print("OPEN: The door start to close")
        print("OPEN: The door is closed")
        return StopState()
    }
    override func run() -> LiftState {
        print("OPEN: Run Forbidden")
        return self
    }
    override func stop() -> LiftState {
        print("OPEN: Stop Forbidden")
        return self
    }
}
class RunState: LiftState {
    override func open() -> LiftState {
        print("RUN: Open Forbidden")
        return self
    }
    override func close() -> LiftState {
        print("RUN: Close Forbidden")
        return self
    }
    override func run() -> LiftState {
        print("RUN: The life is runing")
        return self
    }
    override func stop() -> LiftState {
        print("RUN: The lift start to stop")
        print("RUN: The lift is stopped")
        return StopState()
    }
}
class StopState: LiftState {
    override func open() -> LiftState {
        print("STOP: The door is opening")
        print("STOP: The door is opened")
        return OpenState()
    }
    override func close() -> LiftState {
        print("STOP: Close Forbidden")
        return self
    }
    override func run() -> LiftState {
        print("STOP: The life start to run")
        return RunState()
    }
    override func stop() -> LiftState {
        print("STOP: The lift is stopped")
        return self
    }
}


class Context: NSObject {
    var lift_state = LiftState()
    func open() {
        self.lift_state = self.lift_state.open()
    }
    func close() {
        self.lift_state = self.lift_state.close()
    }
    func run() {
        self.lift_state = self.lift_state.run()
    }
    func stop() {
        self.lift_state = self.lift_state.stop()
    }
}
