//
//  CXSwiftStudyTests.swift
//  CXSwiftStudyTests
//
//  Created by ymh on 2018/3/19.
//  Copyright © 2018年 CX. All rights reserved.
//

import XCTest
@testable import CXSwiftStudy

class CXSwiftStudyTests: XCTestCase {
    let vc = ViewController()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let a = 0
        
        XCTAssertTrue(a == 0, "true")
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
