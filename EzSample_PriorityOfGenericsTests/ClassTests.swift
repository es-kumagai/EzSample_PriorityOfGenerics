//
//  ClassTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/09.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*
型での呼び出し優先順位を調べます。
ここではクラス継承と型直指定に着目しています。
*/

private func test(v:MyClass) -> String {
	
	return "MyClass"
}

private func test(v:MyClassA) -> String {
	
	return "MyClassA"
}

private func test(v:MyClassB) -> String {
	
	return "MyClassB"
}

private func test(v:MyClassC) -> String {
	
	return "MyClassC"
}

private func test(v:MyClassSubA) -> String {
	
	return "MyClassSubA"
}

private func test(v:MyClassSubB) -> String {
	
	return "MyClassSubB"
}

private func test(v:MyClassAB) -> String {
	
	return "MyClassAB"
}

private func test(v:MySubClass) -> String {
	
	return "MySubClass"
}

private func test(v:MySubClassBaseA) -> String {
	
	return "MySubClassBaseA"
}

private func test(v:MySubClassBaseB) -> String {
	
	return "MySubClassBaseB"
}

private func test(v:MySubClassBaseC) -> String {
	
	return "MySubClassBaseC"
}

private func test(v:MySubClassBaseAB) -> String {
	
	return "MySubClassBaseAB"
}

private func test(v:MySubClassBaseSubA) -> String {
	
	return "MySubClassBaseSubA"
}

private func test(v:MySubClassBaseSubB) -> String {
	
	return "MySubClassBaseSubB"
}

private func test(v:MyClassASubA) -> String {
	
	return "MyClassASubA"
}

private func test(v:MyProtocolC) -> String {

	return "MyProtocolC"
}

private func test(v:MySubClass2WithC) -> String {
	
	return "MySubClass2WithC"
}

//private func test<T:MyProtocolC>(v:T) -> String {
//	
//	return "T:MyProtocolC"
//}

class ClassTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testClassTests() {

		let o1:MyClass = MyClass()
		let o2:MyClass = MySubClass()
		let o3:MySubClass = MySubClass()
		let o4:MyClass = MySubClass1WithC()
		
		NSLog("呼び出される関数は、インスタンスの型ではなく格納した型で決まるようです。")
		
		XCTAssertEqual(test(o1), "MyClass")
		XCTAssertEqual(test(o2), "MyClass")
		XCTAssertEqual(test(o3), "MySubClass")
		XCTAssertEqual(test(o4), "MyClass")
	}
	
	func testClassTypeAndProtocolType() {
		
		let o1:MySubClass1WithC = MySubClass1WithC()
		let o2:MySubClass2WithC = MySubClass2WithC()
		
		// 派生先を明確に想定した関数がなく、MyClass と MyProtocolC の両方が存在するため Ambiguous になる。
//		XCTAssertEqual(test(o1), "MyProtocolC")

		// 型を明記できれば問題なく呼び出せる。
		XCTAssertEqual(test(o1 as MyProtocolC), "MyProtocolC")

		// 継承先を明確に想定した関数があると、継承する MyClass, MyProtocolC に惑わされずに呼ばれる。
		XCTAssertEqual(test(o2), "MySubClass2WithC")
	}
}
