//
//  CXInterpreter.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/29.
//  Copyright © 2017年 CX. All rights reserved.
//
//  解释器模式

import UIKit

//谱
class PlayContext: NSObject {
    var play_text = ""
}

//解释器
class Expression: NSObject {
    //转译谱
    func interpret(context: PlayContext) {
        if context.play_text.count == 0 {
            return
        } else {
            let play_segs = context.play_text.split(separator: " ")
            for play_seg in play_segs {
                var pos = 0
                for ele in play_seg {
                    if ele >= "A" && ele <= "z" {
                        pos += 1
                        continue
                    }
                    break
                }
                
                let str = String(play_seg)
                let play_value = play_seg.substring(from: str.index(str.startIndex, offsetBy: pos))
                let play_chord = play_seg.substring(to: str.index(str.startIndex, offsetBy: pos))
                
                self.execute(play_key: play_chord, play_value: play_value)
            }
        }
    }
    //演奏
    func execute(play_key: String, play_value: String) {
        return
    }
}

//吉他演奏
class NormGuitar: Expression {
    override func execute(play_key: String, play_value: String) {
        print("Normal Guitar Playing -- Chord: \(play_key) Play Tune: \(play_value)")
    }
}
