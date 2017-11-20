//
//  CXDecorator.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/19.
//  Copyright © 2017年 CX. All rights reserved.
//  装饰器模式

import UIKit

class Hero: NSObject {
    var name: String = "英雄"
    func learnSkills() {
        print("学习技能接口");
    }
}

class BlindMonk: Hero {
    override init() {
        super.init()
        self.name = "盲僧";
    }
    
    override func learnSkills() {
        print("盲僧学习技能")
    }
}

class SkillsDecorator: Hero {
    var hero = Hero()
    
    override func learnSkills() {
        print("\(self.hero.name)学习全技能")
    }
}

class Skill_QDecorator: SkillsDecorator {
    var skillName: String = "Q技能"
    
    override func learnSkills() {
        print("\(self.hero.name)学习了技能Q：\(self.skillName)")
    }
}



