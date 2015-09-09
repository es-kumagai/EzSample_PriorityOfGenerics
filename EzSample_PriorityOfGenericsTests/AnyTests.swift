//
//  AnyTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/09.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*!
さまざまな Any を表現して、どれが実行されるか検証します。
*/

class AnyTests: XCTestCase {
	
	override func setUp() {
		super.setUp()
		// Put setup code here. This method is called before the invocation of each test method in the class.
	}
	
	override func tearDown() {
		// Put teardown code here. This method is called after the invocation of each test method in the class.
		super.tearDown()
	}
	
	func testOptionalAny() {
		
		NSLog("Any と Any? が純粋にオプショナルか否かで区別されるかを判定します。")
		NSLog("一切 <T> 系が呼ばれないので、型の合致が優先されている様子です。")
		
		let value1:MyStruct = MyStruct()
		let value2:MyEnum = MyEnum.A
		let value3:MyClass = MyClass()
		let value4:String = "STRING"
		
		let optional1:MyStruct? = MyStruct()
		let optional2:MyEnum? = MyEnum.A
		let optional3:MyClass? = MyClass()
		let optional4:String? = "STRING"
		
		XCTAssertEqual(test(value1), "Any")
		XCTAssertEqual(test(value2), "Any")
		XCTAssertEqual(test(value3), "Any")
		XCTAssertEqual(test(value4), "Any")
		
		XCTAssertEqual(test(optional1), "Any?")
		XCTAssertEqual(test(optional2), "Any?")
		XCTAssertEqual(test(optional3), "Any?")
		XCTAssertEqual(test(optional4), "Any?")
	}
	
	// MARK: 🐠 結論として、一切 <T> 系が呼ばれないので、型の合致が優先されている様子です。"
	// テストの結果は OptionalTests のときの型に対する動きと一致します。
	func testOptionalAnyIllegalPattern() {
		
		NSLog("Any と Any? が純粋にオプショナルか否かで区別されるかを判定します。")
		NSLog("オプショナルな変数を用意したときと Optional(value) としたときの動きの違いがあるようなので testOptionalAny から切り出しました。")
		
		let value1:MyStruct = MyStruct()
		let value2:MyEnum = MyEnum.A
		let value3:MyClass = MyClass()
		let value4:String = "STRING"
		
		let optional1:MyStruct? = MyStruct()
		let optional2:MyEnum? = MyEnum.A
		let optional3:MyClass? = MyClass()
		let optional4:String? = "STRING"
		
		NSLog("オプショナルなインスタンスは Any? になります。")
		
		XCTAssertEqual(test(optional1), "Any?")
		XCTAssertEqual(test(optional2), "Any?")
		XCTAssertEqual(test(optional3), "Any?")
		XCTAssertEqual(test(optional4), "Any?")
		
		NSLog("通常のインスタンスは Any になります。")
		
		XCTAssertEqual(test(value1), "Any")
		XCTAssertEqual(test(value2), "Any")
		XCTAssertEqual(test(value3), "Any")
		XCTAssertEqual(test(value4), "Any")
		
		NSLog("通常のインスタンスを Optional で通すと『なぜか』Any になります。")
		
		XCTAssertEqual(test(Optional(value1)), "Any")
		XCTAssertEqual(test(Optional(value2)), "Any")
		XCTAssertEqual(test(Optional(value3)), "Any")
		XCTAssertEqual(test(Optional(value4)), "Any")
		
		NSLog("XCTAssertEqual が悪さをしてるといけないので取り出しましたが、結果は変りません。")
		NSLog("引数に直接 Optional コンストラクタを通したものを渡したときに、この現象が起こるようです。")
		
		let test1 = test(Optional(value1))
		let test2 = test(Optional(value2))
		let test3 = test(Optional(value3))
		let test4 = test(Optional(value4))
		
		XCTAssertEqual(test1, "Any")
		XCTAssertEqual(test2, "Any")
		XCTAssertEqual(test3, "Any")
		XCTAssertEqual(test4, "Any")
		
		NSLog("通常のインスタンスを Optional で変数に受けてから通せば Any? になります。")
		
		let ov1 = Optional(value1)
		let ov2 = Optional(value2)
		let ov3 = Optional(value3)
		let ov4 = Optional(value4)
		
		XCTAssertEqual(test(ov1), "Any?")
		XCTAssertEqual(test(ov2), "Any?")
		XCTAssertEqual(test(ov3), "Any?")
		XCTAssertEqual(test(ov4), "Any?")
		
		NSLog("キャストするとなぜか大丈夫になります。")
		
		XCTAssertEqual(test(Optional(value1) as Optional<MyStruct>), "Any?")
		XCTAssertEqual(test(Optional(value2) as Optional<MyEnum>), "Any?")
		XCTAssertEqual(test(Optional(value3) as Optional<MyClass>), "Any?")
		XCTAssertEqual(test(Optional(value4) as Optional<String>), "Any?")
		
		XCTAssertEqual(test(Optional(value1) as MyStruct?), "Any?")
		XCTAssertEqual(test(Optional(value2) as MyEnum?), "Any?")
		XCTAssertEqual(test(Optional(value3) as MyClass?), "Any?")
		XCTAssertEqual(test(Optional(value4) as String?), "Any?")
	}
}

private func test(v:Any) -> String {
	
	return "Any"
}

private func test(v:Any?) -> String {
	
	return "Any?"
}

private func test<T>(v:T) -> String {
	
	return "T"
}

private func test<T>(v:T?) -> String {
	
	return "T?"
}

// ⚡️ Generic な <T> と <T:Any> は同じものと判断される。

//private func test<T:Any>(v:T) -> String {
//	
//	return "T:Any"
//}
//
//private func test<T:Any>(v:T?) -> String {
//	
//	return "T:Any?"
//}

