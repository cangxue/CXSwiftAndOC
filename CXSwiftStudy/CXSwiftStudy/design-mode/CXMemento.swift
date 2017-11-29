//
//  CXMemento.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/29.
//  Copyright © 2017年 CX. All rights reserved.
//
//  备忘录模式

import UIKit

//游戏角色
class GameCharactor: NSObject {
    var vitality = 0
    var attack = 0
    var defense = 0
    func displayState() {
        print("Current Values:")
        print("Life: \(self.vitality)\nAttack: \(self.attack)\nDefence: \(self.defense)")
    }
    func initState(vitality: Int, attack: Int, defense: Int) {
        self.vitality = vitality
        self.attack = attack
        self.defense = defense
    }
    func saveState() -> CXMemento {
        return CXMemento(vitality: self.vitality, attack: self.attack, defense: self.defense)
    }
    func recoverState(memento: CXMemento) {
        self.vitality = memento.vitality
        self.attack = memento.attack
        self.defense = memento.defense
    }
    
}
class FightCharactor: GameCharactor {
    func fight() {
        self.vitality -= 10
    }
}
class CXMemento: NSObject {
    var vitality = 0
    var attack = 0
    var defense = 0
    init(vitality: Int, attack: Int, defense: Int) {
        self.vitality = vitality
        self.attack = attack
        self.defense = defense
    }
}
