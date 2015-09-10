//
//  GenericStructWhereSimpleTest.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*!
条件付きジェネリックで、
複数の条件を指定しない、単純な場面を検証します。
*/

private func test<T:BoxProtocol>(v:T) -> String {

	return "T:BoxProtocol"
}

private func test<T:BoxProtocol where T.A : MyProtocolA>(v:T) -> String {
	
	return "T:BoxProtocol where T.A : MyProtocolA"
}

private func test<T:BoxProtocol where T.A : MyProtocolB>(v:T) -> String {
	
	return "T:BoxProtocol where T.A : MyProtocolB"
}

private func test<T:BoxProtocol where T.A : MyProtocolC>(v:T) -> String {
	
	return "T:BoxProtocol where T.A : MyProtocolC"
}

private func test<T:BoxProtocol where T.A : MyProtocolSubA>(v:T) -> String {
	
	return "T:BoxProtocol where T.A : MyProtocolSubA"
}

// where T.A : MyProtocolSubB を対象とした関数は実装しません。


class GenericStructWhereTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGenericsWhere() {

		let z = Box(0, 0)
		let a = Box(MyStructA(), 0)
		let b = Box(MyStructB(), 0)
		let subA = Box(MyStructSubA(), 0)
		let subB = Box(MyStructSubB(), 0)
		let ac = Box(MyStructAC(), 0)
		let bc = Box(MyStructBC(), 0)
//		let subAC = Box(MyStructSubAC(), 0)
//		let subBC = Box(MyStructSubBC(), 0)
//		let ab = Box(MyStructAB(), 0)
//		let subASubB = Box(MyStructSubASubB(), 0)
		let aSubA = Box(MyStructASubA(), 0)
		let bSubB = Box(MyStructBSubB(), 0)
//		let aSubB = Box(MyStructASubB(), 0)
//		let bSubA = Box(MyStructBSubA(), 0)
		
		XCTAssertEqual(test(z), "T:BoxProtocol")
		XCTAssertEqual(test(a), "T:BoxProtocol where T.A : MyProtocolA")
		XCTAssertEqual(test(b), "T:BoxProtocol where T.A : MyProtocolB")
		XCTAssertEqual(test(subA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(subB), "T:BoxProtocol where T.A : MyProtocolB")
		
		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(ac), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(bc), "T:BoxProtocol where T.A : MyProtocolB")
		
		// 構造体のため衝突回避と少しやり方が違いますけど、型を合わせてプロトコルにすると、
		// これまでの where ではないときと同様、プロトコル直指定のジェネリックなので Any 扱いになるようです。
		// クラスならキャストで検証できるかも？
		let _ac_a:Box<MyProtocolA, Int> = Box(ac.a, 0)
		let _ac_c:Box<MyProtocolC, Int> = Box(ac.a, 0)
		let _bc_b:Box<MyProtocolB, Int> = Box(bc.a, 0)
		let _bc_c:Box<MyProtocolC, Int> = Box(bc.a, 0)
		
		XCTAssertEqual(test(_ac_a), "T:BoxProtocol")
		XCTAssertEqual(test(_ac_c), "T:BoxProtocol")
		XCTAssertEqual(test(_bc_b), "T:BoxProtocol")
		XCTAssertEqual(test(_bc_c), "T:BoxProtocol")
		
		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(subAC), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(subBC), "T:BoxProtocol where T.A : MyProtocolB")
//		XCTAssertEqual(test(ab), "T:BoxProtocol where T.A : MyProtocolB")
//		XCTAssertEqual(test(subASubB), "T:BoxProtocol where T.A : MyProtocolB")
//		XCTAssertEqual(test(aSubB), "T:BoxProtocol where T.A : MyProtocolB")
//		XCTAssertEqual(test(bSubA), "T:BoxProtocol where T.A : MyProtocolB")

		// これらは衝突しないので大丈夫です。期待通り動作します。
		XCTAssertEqual(test(aSubA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(bSubB), "T:BoxProtocol where T.A : MyProtocolB")
	}
}
