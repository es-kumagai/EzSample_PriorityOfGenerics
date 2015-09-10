//
//  ProtocolTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*
型での呼び出し優先順位を調べます。
ここではプロトコル継承とプロトコル型直指定に着目しています。
ジェネリックとどちらが優先されるかも検証します。
プロトコル型と純粋な型、どちらが優先されるかも検証します。
*/

// 型直指定の場合、Any には、他の該当候補があれば左右されないようです。
// 優先的には、派生、基底、Any の様子です。
private func test(v:Any) -> String {
	
	return "Any"
}

// 型直指定の場合、ジェネリックは完全に後回しになるようです。
private func test<T:MyProtocolA>(v:T) -> String {
	
	return "T:MyProtocolA"
}

private func test<T:MyProtocolB>(v:T) -> String {
	
	return "T:MyProtocolB"
}

private func test<T:MyProtocolC>(v:T) -> String {
	
	return "T:MyProtocolC"
}

// プロトコル版 Any も同様です。型の Any をなくせば、呼ばれる場面も出てきますが、優先度は最も最低です。
private func test<T>(v:T) -> String {
	
	return "T:Any"
}

// Any と protocol<> はビルドで同じ扱いです。
//private func test(v:protocol<>) -> String {
//
//	return "protocol<>"
//}

private func test(v:MyProtocolA) -> String {
	
	return "MyProtocolA"
}

private func test(v:MyProtocolB) -> String {
	
	return "MyProtocolB"
}

private func test(v:MyProtocolC) -> String {
	
	return "MyProtocolC"
}

private func test(v:MyProtocolSubA) -> String {
	
	return "MyProtocolSubA"
}

// MyProtocolSubB は実装しません。


// MySubClass と MyClassC だけ、型を明記した実装をします。
private func test(v:MyClassC) -> String {
	
	return "MyClassC"
}

private func test(v:MySubClass) -> String {
	
	return "MySubClass"
}

class ProtocolTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testProtocol() {

		let o:MyClass = MyClass()
		let a:MyClassA = MyClassA()
		let b:MyClassB = MyClassB()
		let subA:MyClassSubA = MyClassSubA()
		let subB:MyClassSubB = MyClassSubB()
		let ab:MyClassAB = MyClassAB()
		let abAsProtoA:MyProtocolA = MyClassAB()
		let abAsProtoB:MyProtocolB = MyClassAB()
		let subO:MySubClass = MySubClass()
		let subO1WithC:MySubClass1WithC = MySubClass1WithC()
		let subO2WithC:MySubClass2WithC = MySubClass2WithC()
		let protoC:MyProtocolC = MySubClass1WithC()
		let subOBaseA:MySubClassBaseA = MySubClassBaseA()
		let subOBaseB:MySubClassBaseB = MySubClassBaseB()
		let subOBaseC:MySubClassBaseC = MySubClassBaseC()
		let subOAsBase:MyClass = MySubClass()
		let subOBaseAAsBase:MyClassA = MySubClassBaseA()
		let subOBaseBAsBase:MyClassB = MySubClassBaseB()
		let subOBaseAB:MySubClassBaseAB = MySubClassBaseAB()
		let subOBaseSubA:MySubClassBaseSubA = MySubClassBaseSubA()
		let subOBaseSubB:MySubClassBaseSubB = MySubClassBaseSubB()
		
		// 他に該当するものがないため、無名プロトコルに合致します。
		XCTAssertEqual(test(o), "Any")
		
		XCTAssertEqual(test(a), "MyProtocolA")
		XCTAssertEqual(test(b), "MyProtocolB")
		XCTAssertEqual(test(subA), "MyProtocolSubA")
		XCTAssertEqual(test(subB), "MyProtocolB")

		// A と B に対等に該当するため Ambiguous になる
//		XCTAssertEqual(test(ab), "Protocol")
//		XCTAssertEqual(test(subOBaseAB), "MyProtocolA")
		
		// 型を明記すれば大丈夫。基底クラスが準拠するプロトコルへもキャストできる。
		XCTAssertEqual(test(ab as MyProtocolA), "MyProtocolA")
		XCTAssertEqual(test(subOBaseAB as MyProtocolB), "MyProtocolB")

		// 同様に変数に受けるときに型を明記すれば OK です。
		XCTAssertEqual(test(abAsProtoA), "MyProtocolA")
		XCTAssertEqual(test(abAsProtoB), "MyProtocolB")

		
		// クラスの型がぴったり一致する関数があるため、それに合致する。
		XCTAssertEqual(test(subO), "MySubClass")

		XCTAssertEqual(test(subO1WithC), "MyProtocolC")
		XCTAssertEqual(test(subO2WithC), "MyProtocolC")
		XCTAssertEqual(test(protoC), "MyProtocolC")

		XCTAssertEqual(test(subOBaseA), "MyProtocolA")
		XCTAssertEqual(test(subOBaseB), "MyProtocolB")
		
		// 基底クラスで受けたものは、基底クラスを想定したものが呼び出されます。
		// たとえば MySubClass は合致する関数がありますが、親で縛っていて、親に完全合致する関数がないため Any が呼ばれます。
		XCTAssertEqual(test(subOAsBase), "Any")
		XCTAssertEqual(test(subOBaseAAsBase), "MyProtocolA")
		XCTAssertEqual(test(subOBaseBAsBase), "MyProtocolB")
		
		// 親クラスの型がぴったり一致する関数があるため、それに合致する。
		XCTAssertEqual(test(subOBaseC), "MyClassC")
		XCTAssertEqual(test(subOBaseSubA), "MyProtocolSubA")
		
		// 継承元について、SubB がなければ B に該当する。
		// プロトコルでも型指定であれば、Any 型には邪魔されない。
		XCTAssertEqual(test(subOBaseSubB), "MyProtocolB")
	}
}
