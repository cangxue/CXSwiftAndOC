//
//  CXTimerViewController.swift
//  CXSwiftStudy
//
//  Created by ymh on 2018/5/14.
//  Copyright © 2018年 CX. All rights reserved.
//

import UIKit

class CXTimerViewController: UIViewController {
    
    var text = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let label1 = UILabel(frame: CGRect(x: 0, y: 80, width: 200, height: 30))
        label1.backgroundColor = UIColor.yellow
        label1.textColor = UIColor.black
        self.view.addSubview(label1)

        DispatchTimer(timeInterval: 1, repeatCount: 1000) { (timer, count) in
            
            self.timeformatFromSeconds(seconds: count)
            label1.text = self.text
        }
        
        let label2 = UILabel(frame: CGRect(x: 0, y: 180, width: 200, height: 30))
        label2.backgroundColor = UIColor.yellow
        label2.textColor = UIColor.black
        self.view.addSubview(label2)
        
        DispatchTimer(timeInterval: 1, repeatCount: 88) { (timer, count) in
            
            self.timeformatFromSeconds(seconds: count)
            label2.text = self.text
        }
        
        
        let label3 = UILabel(frame: CGRect(x: 0, y: 280, width: 200, height: 30))
        label3.backgroundColor = UIColor.yellow
        label3.textColor = UIColor.black
        self.view.addSubview(label3)
        
        DispatchTimer(timeInterval: 1, repeatCount: 131) { (timer, count) in
            
            self.timeformatFromSeconds(seconds: count)
            label3.text = self.text
        }
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func timeformatFromSeconds(seconds: Int) {
        if seconds > 0 {
            var text = "剩余:"
            if (seconds / 86400) >= 1 {
                text += "\(seconds / 86400)天"
                if (seconds % 86400 / 3600) >= 1 {
                    text += "\(seconds % 86400 / 3600)小时"
                    if (seconds % 3600 / 60) >= 1 {
                        text += "\(seconds % 3600 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                } else {
                    text += "00小时"
                    if (seconds % 86400 / 60) >= 1 {
                        text += "\(seconds % 86400 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                }
            } else {
                text += "0天"
                if (seconds / 3600) >= 1 {
                    text += "\(seconds / 3600)小时"
                    if (Int(seconds) % 3600 / 60) >= 1 {
                        text += "\(seconds % 3600 / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                } else {
                    text += "00小时"
                    if (seconds / 60) >= 1 {
                        text += "\(seconds / 60)分\(seconds % 60)秒"
                    } else {
                        text += "00分\(seconds % 60)秒"
                    }
                }
            }
            self.text = text
        } else {
            self.text = "抢购已结束"
        }
    }
    
    

    /// GCD定时器倒计时
    ///   - timeInterval: 循环间隔时间
    ///   - repeatCount: 重复次数
    ///   - handler: 循环事件, 闭包参数： 1. timer， 2. 剩余执行次数
    
    public func DispatchTimer(timeInterval: Double, repeatCount:Int, handler:@escaping (DispatchSourceTimer?, Int)->())
    {
        if repeatCount <= 0 {
            return
        }
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        var count = repeatCount
        timer.scheduleRepeating(deadline: .now(), interval: timeInterval)
        timer.setEventHandler(handler: {
            count -= 1
            DispatchQueue.main.async {
                handler(timer, count)
            }
            if count == 0 {
                timer.cancel()
            }
        })
        timer.resume()
    }
    
    /// GCD定时器循环操作
    ///   - timeInterval: 循环间隔时间
    ///   - handler: 循环事件
    public func DispatchTimer(timeInterval: Double, handler:@escaping (DispatchSourceTimer?)->())
    {
        let timer = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.main)
        timer.scheduleRepeating(deadline: .now(), interval: timeInterval)
        timer.setEventHandler {
            DispatchQueue.main.async {
                handler(timer)
            }
        }
        timer.resume()
    }

    /// GCD延时操作
    ///   - after: 延迟的时间
    ///   - handler: 事件
    public func DispatchAfter(after: Double, handler:@escaping ()->())
    {
        DispatchQueue.main.asyncAfter(deadline: .now() + after) {
            handler()
        }
    }
}
