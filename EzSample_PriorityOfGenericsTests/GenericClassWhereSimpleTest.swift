//
//  GenericClassWhereSimpleTest.swift
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


class GenericClassWhereTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGenericsWhereWithStructBox() {

		let z = Box(0, 0)
		let a = Box(MyClassA(), 0)
		let b = Box(MyClassB(), 0)
		let subA = Box(MyClassSubA(), 0)
		let subB = Box(MyClassSubB(), 0)
		let sub1c = Box(MySubClass1WithC(), 0)
		let sub2c = Box(MySubClass2WithC(), 0)
		let ab = Box(MyClassAB(), 0)
		let subAC = Box(MySubClassAWithC(), 0)
		let subBC = Box(MySubClassBWithC(), 0)
		let aSubA = Box(MyClassASubA(), 0)
//		let baseAB = Box(MySubClassBaseAB(), 0)
		let baseA = Box(MySubClassBaseA(), 0)
		let baseB = Box(MySubClassBaseB(), 0)
		let baseSubA = Box(MySubClassBaseSubA(), 0)
		let baseSubB = Box(MySubClassBaseSubB(), 0)
		
		XCTAssertEqual(test(z), "T:BoxProtocol")
		XCTAssertEqual(test(a), "T:BoxProtocol where T.A : MyProtocolA")
		XCTAssertEqual(test(b), "T:BoxProtocol where T.A : MyProtocolB")
		XCTAssertEqual(test(subA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(subB), "T:BoxProtocol where T.A : MyProtocolB")

		XCTAssertEqual(test(sub1c), "T:BoxProtocol where T.A : MyProtocolC")
		XCTAssertEqual(test(sub2c), "T:BoxProtocol where T.A : MyProtocolC")

		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(ab), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(subAC), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(subBC), "T:BoxProtocol where T.A : MyProtocolA")

		// 構造体のため衝突回避と少しやり方が違いますけど、型を合わせてプロトコルにすると、
		// これまでの where ではないときと同様、プロトコル直指定のジェネリックなので Any 扱いになるようです。
		// 中身がクラスならキャストで検証できるかも？と思いましたが、できませんでした。
		let _ab_a:Box<MyProtocolA, Int> = Box(ab.a, 0)
		let _ab_b:Box<MyProtocolB, Int> = Box(ab.a, 0)
		let _subAC_a:Box<MyProtocolA, Int> = Box(subAC.a, 0)
		let _subBC_b:Box<MyProtocolB, Int> = Box(subBC.a, 0)
		let _subAC_c:Box<MyProtocolC, Int> = Box(subAC.a, 0)
		let _subBC_c:Box<MyProtocolC, Int> = Box(subBC.a, 0)
		
		XCTAssertEqual(test(_ab_a), "T:BoxProtocol")
		XCTAssertEqual(test(_ab_b), "T:BoxProtocol")
		
		XCTAssertEqual(test(_subAC_a), "T:BoxProtocol")
		XCTAssertEqual(test(_subBC_b), "T:BoxProtocol")
		XCTAssertEqual(test(_subAC_c), "T:BoxProtocol")
		XCTAssertEqual(test(_subBC_c), "T:BoxProtocol")
		
		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(baseAB), "T:BoxProtocol where T.A : MyProtocolB")
		
		// これらは衝突しないので大丈夫です。期待通り動作します。
		XCTAssertEqual(test(aSubA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(baseA), "T:BoxProtocol where T.A : MyProtocolA")
		XCTAssertEqual(test(baseB), "T:BoxProtocol where T.A : MyProtocolB")
		XCTAssertEqual(test(baseSubA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(baseSubB), "T:BoxProtocol where T.A : MyProtocolB")
	}

    func testGenericsWhereWithClassBox() {

		let z = CBox(0, 0)
		let a = CBox(MyClassA(), 0)
		let b = CBox(MyClassB(), 0)
		let subA = CBox(MyClassSubA(), 0)
		let subB = CBox(MyClassSubB(), 0)
		let sub1c = CBox(MySubClass1WithC(), 0)
		let sub2c = CBox(MySubClass2WithC(), 0)
		let ab = CBox(MyClassAB(), 0)
		let subAC = CBox(MySubClassAWithC(), 0)
		let subBC = CBox(MySubClassBWithC(), 0)
		let aSubA = CBox(MyClassASubA(), 0)
//		let baseAB = CBox(MySubClassBaseAB(), 0)
		let baseA = CBox(MySubClassBaseA(), 0)
		let baseB = CBox(MySubClassBaseB(), 0)
		let baseSubA = CBox(MySubClassBaseSubA(), 0)
		let baseSubB = CBox(MySubClassBaseSubB(), 0)
		
		XCTAssertEqual(test(z), "T:BoxProtocol")
		XCTAssertEqual(test(a), "T:BoxProtocol where T.A : MyProtocolA")
		XCTAssertEqual(test(b), "T:BoxProtocol where T.A : MyProtocolB")
		XCTAssertEqual(test(subA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(subB), "T:BoxProtocol where T.A : MyProtocolB")

		XCTAssertEqual(test(sub1c), "T:BoxProtocol where T.A : MyProtocolC")
		XCTAssertEqual(test(sub2c), "T:BoxProtocol where T.A : MyProtocolC")

		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(ab), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(subAC), "T:BoxProtocol where T.A : MyProtocolA")
//		XCTAssertEqual(test(subBC), "T:BoxProtocol where T.A : MyProtocolA")

		// 構造体のため衝突回避と少しやり方が違いますけど、型を合わせてプロトコルにすると、
		// これまでの where ではないときと同様、プロトコル直指定のジェネリックなので Any 扱いになるようです。
		// 中身がクラスならキャストで検証できるかも？と思いましたが、できませんでした。
		
		// ボックスをクラス型にしてもダメでした。
//		let _ab_a:CBox<MyProtocolA, Int> = ab as! CBox<MyProtocolA, Int>
		let _ab_a:CBox<MyProtocolA, Int> = CBox(ab.a, 0)
		let _ab_b:CBox<MyProtocolB, Int> = CBox(ab.a, 0)
		let _subAC_a:CBox<MyProtocolA, Int> = CBox(subAC.a, 0)
		let _subBC_b:CBox<MyProtocolB, Int> = CBox(subBC.a, 0)
		let _subAC_c:CBox<MyProtocolC, Int> = CBox(subAC.a, 0)
		let _subBC_c:CBox<MyProtocolC, Int> = CBox(subBC.a, 0)

		XCTAssertEqual(test(_ab_a), "T:BoxProtocol")
		XCTAssertEqual(test(_ab_b), "T:BoxProtocol")
		
		XCTAssertEqual(test(_subAC_a), "T:BoxProtocol")
		XCTAssertEqual(test(_subBC_b), "T:BoxProtocol")
		XCTAssertEqual(test(_subAC_c), "T:BoxProtocol")
		XCTAssertEqual(test(_subBC_c), "T:BoxProtocol")
		
		// プロトコルではなく型へのキャストであれば通るかと思いましたが、
		// この方法でも必ず失敗する都の警告が出たため断念します。
//		let _subAC_classA:CBox<MyClassA, Int> = subAC as! CBox<MyClassA, Int>
//		let _subBC_classB:CBox<MyClassB, Int> = subBC as! CBox<MyClassB, Int>
//		XCTAssertEqual(test(_subAC_classA), "T:BoxProtocol")
//		XCTAssertEqual(test(_subBC_classB), "T:BoxProtocol")
		
		
		// MyProtocolA と MyProtocolC の両方を持っているため、衝突します。
//		XCTAssertEqual(test(baseAB), "T:BoxProtocol where T.A : MyProtocolB")
		
		// これらは衝突しないので大丈夫です。期待通り動作します。
		XCTAssertEqual(test(aSubA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(baseA), "T:BoxProtocol where T.A : MyProtocolA")
		XCTAssertEqual(test(baseB), "T:BoxProtocol where T.A : MyProtocolB")
		XCTAssertEqual(test(baseSubA), "T:BoxProtocol where T.A : MyProtocolSubA")
		XCTAssertEqual(test(baseSubB), "T:BoxProtocol where T.A : MyProtocolB")
	}
}
