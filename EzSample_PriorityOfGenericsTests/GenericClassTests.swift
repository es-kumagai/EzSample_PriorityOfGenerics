//
//  GenericClassTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/09.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*
型での呼び出し優先順位を調べます。
ここではクラス継承とジェネリックでの条件縛りに着目しています。
クラスでのジェネリック明記はできないので、プロトコルで縛ります。
*/

//private func test<T where T == MyClass>(v:T) -> String {
//	
//}

private func test<T:Any>(v:T) -> String {
	
	return "T:Any"
}

private func test<T:MyProtocolA>(v:T) -> String {
	
	return "T:MyProtocolA"
}

private func test<T:MyProtocolB>(v:T) -> String {
	
	return "T:MyProtocolB"
}

private func test<T:MyProtocolC>(v:T) -> String {
	
	return "T:MyProtocolC"
}

private func test<T:MyProtocolSubA>(v:T) -> String {
	
	return "T:MyProtocolSubA"
}

// ProtocolSubB については実装しません。

class GenericClassTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testGenericClass() {

		let o:MyClass = MyClass()
		let a:MyClassA = MyClassA()
		let b:MyClassB = MyClassB()
		let subA:MyClassSubA = MyClassSubA()
		let subB:MyClassSubB = MyClassSubB()
		let ab:MyClassAB = MyClassAB()
		let abAsProtoA:MyProtocolA = MyClassAB()
		let abAsProtoB:MyProtocolB = MyClassAB()
//		let subO:MySubClass = MySubClass()
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
		XCTAssertEqual(test(o), "T:Any")
		
		XCTAssertEqual(test(a), "T:MyProtocolA")
		XCTAssertEqual(test(b), "T:MyProtocolB")
		XCTAssertEqual(test(subA), "T:MyProtocolSubA")
		XCTAssertEqual(test(subB), "T:MyProtocolB")
		
		// A と B に対等に該当するため Ambiguous になる
//		XCTAssertEqual(test(ab), "Protocol")
//		XCTAssertEqual(test(subOBaseAB), "MyProtocolA")
		
		// 🔥型直指定では大丈夫だったが、ジェネリックの場合は Any 扱いになる。
		XCTAssertNotEqual(test(ab as MyProtocolA), "T:MyProtocolA")
		XCTAssertNotEqual(test(subOBaseAB as MyProtocolB), "T:MyProtocolB")
		
		// 🔥同様に変数に受けるときに型を明記していても Any 扱いになる。
		
		// 🔥🔥 Any 扱いになるというより、MyProtocolA や MyProtocolB に合致しないようだ。
		
		// 以下の仮説を立てたが、これは間違っているようだ。
		// 直接準拠させている基底クラスでは問題ないが、そこから派生したクラスは、ジェネリックでは判定できないようだ。
		// つまり、型直してなら継承元のプロトコルを判断できるが、ジェネリックでは判断できない。
		// 🔥仮説。おそらく、プロトコル型はジェネリックでは Any でしかひっかけられない。
		XCTAssertEqual(test(abAsProtoA), "T:Any")
		XCTAssertEqual(test(abAsProtoB), "T:Any")
		

		// サブクラスが継承している型を、サブクラスのインスタンスでジェネリックによる篩い分けは大丈夫。
		// これは型直指定と同じ動作。
		XCTAssertEqual(test(subO1WithC), "T:MyProtocolC")
		XCTAssertEqual(test(subO2WithC), "T:MyProtocolC")
		
		// ProtocolC として受けた型なのに、それが明記されたジェネリックにかからない。
		// なぜ Any になるのか。
		// 🔥仮説。おそらく、プロトコル型はジェネリックでは Any でしかひっかけられない。
		XCTAssertEqual(test(protoC), "T:Any")
		
		// 型で持つインスタンスなら、プロトコルでひっかけられる。
		XCTAssertEqual(test(subOBaseA), "T:MyProtocolA")
		XCTAssertEqual(test(subOBaseB), "T:MyProtocolB")
		
		// 基底クラスで受けたものは、基底クラスを想定したものが呼び出されます。
		// たとえば MySubClass は合致する関数がありますが、親で縛っていて、親に完全合致する関数がないため Any が呼ばれます。
		XCTAssertEqual(test(subOAsBase), "T:Any")
		XCTAssertEqual(test(subOBaseAAsBase), "T:MyProtocolA")
		XCTAssertEqual(test(subOBaseBAsBase), "T:MyProtocolB")
		
		XCTAssertEqual(test(subOBaseC), "T:MyProtocolC")
		XCTAssertEqual(test(subOBaseSubA), "T:MyProtocolSubA")
		
		// 継承元について、SubB がなければ B に該当する。
		// プロトコルでも型指定であれば、Any 型には邪魔されない。
		XCTAssertEqual(test(subOBaseSubB), "T:MyProtocolB")
	}
	
	func testProtocolTypeUsingGeneric() {
		
		// プロトコル型での取り回しが、ジェネリックにマッチしないのではないかという仮説。
		let a:MyProtocolA = MyClassA()
		let b:MyProtocolB = MyClassB()
		let a2:MyProtocolA = MyClassAB()
		let b2:MyProtocolB = MyClassAB()
		let c:MyProtocolC = MyClassC()
		let subA:MyProtocolA = MyClassSubA()
		let subB:MyProtocolB = MyClassSubB()
		let subBaseA:MyProtocolA = MySubClassBaseA()
		let subBaseB:MyProtocolB = MySubClassBaseB()
		let subBaseC:MyProtocolC = MySubClassBaseC()
		let sub1C:MyProtocolC = MySubClass1WithC()
		let sub2C:MyProtocolC = MySubClass2WithC()

		XCTAssertEqual(test(a), "T:Any")
		XCTAssertEqual(test(b), "T:Any")
		XCTAssertEqual(test(a2), "T:Any")
		XCTAssertEqual(test(b2), "T:Any")
		XCTAssertEqual(test(c), "T:Any")
		XCTAssertEqual(test(subA), "T:Any")
		XCTAssertEqual(test(subB), "T:Any")
		XCTAssertEqual(test(subBaseA), "T:Any")
		XCTAssertEqual(test(subBaseB), "T:Any")
		XCTAssertEqual(test(subBaseC), "T:Any")
		XCTAssertEqual(test(sub1C), "T:Any")
		XCTAssertEqual(test(sub2C), "T:Any")
	}
}
