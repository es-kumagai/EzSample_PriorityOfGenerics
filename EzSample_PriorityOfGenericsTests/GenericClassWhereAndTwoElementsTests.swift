//
//  GenericClassWhereAndTwoElementsTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*!
条件付きジェネリックで、
複数の条件を複数要素に対して指定する場面を検証します。
*/

class GenericClassWhereAndTwoElementsTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testCross() {

//		let a:MyClassA = MyClassA()
//		let subBaseBWithC:MySubClassBWithC = MySubClassBWithC()
//		let subBaseBWithCAsB:MyClassB = MySubClassBWithC()
//		
//		let subBaseAWithC:MySubClassAWithC = MySubClassAWithC()
//		let subBaseAWithCAsA:MyClassA = MySubClassAWithC()

		// SubB : B, ProC で B: ProB のときに
		// SubB かつ ProC や B かつ ProC を検証しようと思いましたが、
		// ジェネリックでは型で縛った後にそれが準拠するプロトコルで判定みたいなことができないため、
		// 検証することがありませんでした。
		// 型のエクステンションだと少し違ってくるかもしれませんが、そうでもないかもしれません。
	}

}
