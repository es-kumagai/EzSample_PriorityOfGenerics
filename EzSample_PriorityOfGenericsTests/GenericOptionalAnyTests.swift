//
//  GenericOptionalAnyTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/09.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*!
型ではなくジェネリックで縛ったときのテストです。
特に Any 型を <T> で表現したときの OptionalTests で検証した項の動きを再検証します。
*/

private func test<T:Any>(v:T) -> String {
	
	return "T"
}

private func test<T>(v:T?) -> String {
	
	return "T?"
}

class GenericOptionalTests: XCTestCase {

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
		NSLog("型が Any な場合、オプショナル")
		
		let value1:MyStruct = MyStruct()
		let value2:MyEnum = MyEnum.A
		let value3:MyClass = MyClass()
		let value4:String = "STRING"
		
		let optional1:MyStruct? = MyStruct()
		let optional2:MyEnum? = MyEnum.A
		let optional3:MyClass? = MyClass()
		let optional4:String? = "STRING"
		
		XCTAssertEqual(test(value1), "T")
		XCTAssertEqual(test(value2), "T")
		XCTAssertEqual(test(value3), "T")
		XCTAssertEqual(test(value4), "T")
		
		XCTAssertEqual(test(optional1), "T?")
		XCTAssertEqual(test(optional2), "T?")
		XCTAssertEqual(test(optional3), "T?")
		XCTAssertEqual(test(optional4), "T?")
	}
	
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
		
		XCTAssertEqual(test(optional1), "T?")
		XCTAssertEqual(test(optional2), "T?")
		XCTAssertEqual(test(optional3), "T?")
		XCTAssertEqual(test(optional4), "T?")
		
		NSLog("通常のインスタンスは Any になります。")
		
		XCTAssertEqual(test(value1), "T")
		XCTAssertEqual(test(value2), "T")
		XCTAssertEqual(test(value3), "T")
		XCTAssertEqual(test(value4), "T")
		
		NSLog("通常のインスタンスを Optional で通したときは、感覚的に正しく Any? になります。")
		
		XCTAssertEqual(test(Optional(value1)), "T?")
		XCTAssertEqual(test(Optional(value2)), "T?")
		XCTAssertEqual(test(Optional(value3)), "T?")
		XCTAssertEqual(test(Optional(value4)), "T?")
		
		NSLog("以降は型の Any で判定していたのと同じテストです。")
		NSLog("既に意図通りに動いているので、不要なテストとも言えます。")
		
		let test1 = test(Optional(value1))
		let test2 = test(Optional(value2))
		let test3 = test(Optional(value3))
		let test4 = test(Optional(value4))
		
		XCTAssertEqual(test1, "T?")
		XCTAssertEqual(test2, "T?")
		XCTAssertEqual(test3, "T?")
		XCTAssertEqual(test4, "T?")
		
		let ov1 = Optional(value1)
		let ov2 = Optional(value2)
		let ov3 = Optional(value3)
		let ov4 = Optional(value4)
		
		XCTAssertEqual(test(ov1), "T?")
		XCTAssertEqual(test(ov2), "T?")
		XCTAssertEqual(test(ov3), "T?")
		XCTAssertEqual(test(ov4), "T?")
		
		
		XCTAssertEqual(test(Optional(value1) as Optional<MyStruct>), "T?")
		XCTAssertEqual(test(Optional(value2) as Optional<MyEnum>), "T?")
		XCTAssertEqual(test(Optional(value3) as Optional<MyClass>), "T?")
		XCTAssertEqual(test(Optional(value4) as Optional<String>), "T?")
		
		XCTAssertEqual(test(Optional(value1) as MyStruct?), "T?")
		XCTAssertEqual(test(Optional(value2) as MyEnum?), "T?")
		XCTAssertEqual(test(Optional(value3) as MyClass?), "T?")
		XCTAssertEqual(test(Optional(value4) as String?), "T?")
	}
}
