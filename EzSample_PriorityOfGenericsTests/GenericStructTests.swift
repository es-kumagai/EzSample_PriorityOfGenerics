//
//  GenericStructTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/09.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

private func test(v:Int) -> String {
	
	return "Int"
}

private func test<T:Any>(v:T) -> String {
	
	return "Any"
}

private func test<T:Equatable>(v:T) -> String {
	
	return "Equatable"
}

private func test<T:Comparable>(v:T) -> String {
	
	return "Comparable"
}

private func test<T:StringLiteralConvertible>(v:T) -> String {
	
	return "StringLiteralConvertible"
}

private func test<T:MyProtocolA>(v:T) -> String {
	
	return "MyProtocolA"
}

private func test<T:MyProtocolB>(v:T) -> String {
	
	return "MyProtocolB"
}

private func test<T:MyProtocolC>(v:T) -> String {
	
	return "MyProtocolC"
}

// ProtocolB 系だけ B と SubB とを用意します。
private func test<T:MyProtocolSubB>(v:T) -> String {
	
	return "MyProtocolSubB"
}


/*
型での呼び出し優先順位を調べます。
ここでは Any を除くジェネリックで縛った場合に着目しています。
型による優先性も合わせて検証します。
*/

class GenericStructTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGenericStruct() {

		let i:Int = 10
		let d:Double = 10.1
		let s:String = "TEST"
		
		XCTAssertEqual(test(i), "Int")
		
		
		XCTAssertEqual(test(d), "Comparable")
		
		// StringLiteralConvertible と Comparable が対等にあるため Ambiguous になる。
		// そしてどちらも Generic なプロトコルのため、明示キャスト不可
//		XCTAssertEqual(test(s), "???")
	}
	
	func testGenericProtocolInherit() {
		
		let a:MyStructA = MyStructA()
		let b:MyStructB = MyStructB()
		let ac:MyStructAC = MyStructAC()
		let bc:MyStructBC = MyStructBC()
		let subA:MyStructSubA = MyStructSubA()
		let subB:MyStructSubB = MyStructSubB()
		let subAC:MyStructSubAC = MyStructSubAC()
		let subBC:MyStructSubBC = MyStructSubBC()
		let aSubA:MyStructASubA = MyStructASubA()
		let bSubB:MyStructBSubB = MyStructBSubB()
		let ab:MyStructAB = MyStructAB()
		let subASubB:MyStructSubASubB = MyStructSubASubB()
		
		XCTAssertEqual(test(a), "MyProtocolA")
		XCTAssertEqual(test(b), "MyProtocolB")
		
		// ProtocolA や ProtocolB と ProtocolC が衝突するため Ambiguous です。
//		XCTAssertEqual(test(ac), "MyProtocolA")
//		XCTAssertEqual(test(bc), "MyProtocolB")
		
		// プロトコルでキャストすると、クラスのときと同様、Any 扱いになります。
		// 関数がジェネリック縛りなためで、型明記の場合はプロトコルにあったものが選ばれます。
		XCTAssertEqual(test(ac as MyProtocolA), "Any")
		XCTAssertEqual(test(bc as MyProtocolB), "Any")
		
		XCTAssertEqual(test(subA), "MyProtocolA")
		XCTAssertEqual(test(subB), "MyProtocolSubB")
		
		// ProtocolA や ProtocolB と ProtocolC が衝突するため Ambiguous です。
//		XCTAssertEqual(test(subAC), "MyProtocolA")
//		XCTAssertEqual(test(subBC), "MyProtocolB")
		// プロトコルでキャストすると、クラスのときと同様、Any 扱いになります。
		// 関数がジェネリック縛りなためで、型明記の場合はプロトコルにあったものが選ばれます。
		XCTAssertEqual(test(subAC as MyProtocolA), "Any")
		XCTAssertEqual(test(subBC as MyProtocolB), "Any")
		XCTAssertEqual(test(subAC as MyProtocolC), "Any")
		XCTAssertEqual(test(subBC as MyProtocolC), "Any")
		
		XCTAssertEqual(test(aSubA), "MyProtocolA")
		XCTAssertEqual(test(bSubB), "MyProtocolSubB")
		// プロトコルでキャストすると、クラスのときと同様、Any 扱いになります。
		// 関数がジェネリック縛りなためで、型明記の場合はプロトコルにあったものが選ばれます。
		XCTAssertEqual(test(aSubA as MyProtocolA), "Any")
		XCTAssertEqual(test(bSubB as MyProtocolB), "Any")

		// ProtocolA と ProtocolB とが衝突するため Ambiguous です。
//		XCTAssertEqual(test(ab), "MyProtocolSubB")
		// プロトコルでキャストすると、クラスのときと同様、Any 扱いになります。
		// 関数がジェネリック縛りなためで、型明記の場合はプロトコルにあったものが選ばれます。
		XCTAssertEqual(test(ab as MyProtocolA), "Any")
		XCTAssertEqual(test(ab as MyProtocolB), "Any")

		// ProtocolSubA が ProtocolA に合致して、ProtocolSubB も別のに合致するため Ambiguous です。
//		XCTAssertEqual(test(subASubB), "MyProtocolSubB")
		// プロトコルでキャストすると、クラスのときと同様、Any 扱いになります。
		// 関数がジェネリック縛りなためで、型明記の場合はプロトコルにあったものが選ばれます。
		XCTAssertEqual(test(subASubB as MyProtocolSubB), "Any")
	}
}
