//
//  CXPrototype.swift
//  CXSwiftStudy
//
//  Created by xiaoma on 2017/11/14.
//  Copyright © 2017年 CX. All rights reserved.
//

import UIKit

class CXSimpleLayer: NSObject, NSCopying {
    
    
    var background = [0, 0, 0, 0]
    var content = "blank"
    
    init(background: Array<Any>, content: String) {
        self.background = background as! [Int];
        self.content = content;
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        return CXSimpleLayer(background: background, content: content)
    }
}



