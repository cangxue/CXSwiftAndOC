//
//  CXIterator.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/24.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class Novella: NSObject {
    var name = ""
    
    init(name: String) {
        self.name = name
    }
    
}

class Novellas: NSObject {
    var novellas: [Novella] = []
    init(novellas: Array<Novella>) {
        self.novellas = novellas
    }
}

class NovellasIterator: IteratorProtocol {
    typealias Element = Novella

    private var current = 0
    private var novellas: [Novella] = []
    init(novellas: [Novella]) {
        self.novellas = novellas
    }

    //实现协议方法

    func next() -> Novella? {
        defer {
            current += 1 //当方法结束后当前所引值+1
        }

        guard current < novellas.count else {
            print("结束了")
            return nil
        }

        return novellas[current]
    }
}

//将小说集合遵循Swift序列协议
extension Novellas: Sequence {
    //实现协议方法(制作一个小说迭代器)
    func makeIterator() -> NovellasIterator {
        return NovellasIterator(novellas: novellas)
    }
}

