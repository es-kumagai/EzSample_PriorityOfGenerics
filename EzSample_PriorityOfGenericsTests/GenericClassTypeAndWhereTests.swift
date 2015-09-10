//
//  GenericClassTypeAndWhereTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*
全てジェネリックで解決する場合と、
型が一致してジェネリックで解決する場合の両方を検証します。

型部分がジェネリックの場合と直指定の場合で where 句が一致するときどうなるか。
*/

class GenericClassTypeAndWhereTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
