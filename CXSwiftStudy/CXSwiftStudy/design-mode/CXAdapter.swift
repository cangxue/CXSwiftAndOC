//
//  CXAdapter.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/20.
//  Copyright © 2017年 CX. All rights reserved.
//  适配器模式

import UIKit

//接口类
class MediaPlayer: NSObject {
    func play(fileName: String) {
        print("播放文件: \(fileName)")
    }
}
class AdvanceMediaPlayer: NSObject {
    func playMp4(fileName: String) {
        print("播放mp4文件：\(fileName)")
    }
}

//适配器
class MediaAdapter: MediaPlayer {
    let advancePlayer = AdvanceMediaPlayer()
    
    override func play(fileName: String) {
        self.advancePlayer.playMp4(fileName: fileName)
    }
}
