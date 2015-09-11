//
//  GenericClassWhereAndTests.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

import XCTest

/*!
条件付きジェネリックで、
複数の条件を単一要素に対して指定する場面を検証します。
*/

private func test<A,B>(a:A, _ b:B) -> String {
	
	return "A,B"
}

// 両方の型が一致した場合に、
private func test<A>(a:A, _ b:A) -> String {
	
	return "A"
}

private func test<A,B where A:MyProtocolA, B:MyProtocolA>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolA"
}

private func test<A,B where A:MyProtocolA, B:MyProtocolB>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolB"
}

private func test<A,B where A:MyProtocolA, B:MyProtocolC>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolC"
}

private func test<A,B where A:MyProtocolSubA, B:MyProtocolSubB>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolSubA, B:MyProtocolSubB"
}

private func test<A,B where A:MyProtocolA, B:MyProtocolSubB>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolSubB"
}

private func test<A,B where A:MyProtocolC, B:MyProtocolB>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolC, B:MyProtocolB"
}

private func test<A,B where A:MyProtocolC, B:MyProtocolSubB>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolC, B:MyProtocolSubB"
}

private func sameTypeTest<A,B>(a:A, _ b:B) -> String {
	
	return "A,B"
}

private func sameTypeTest<A>(a:A, _ b:A) -> String {
	
	return "A"
}

private func sameEquatableTest<A:Equatable,B:Equatable>(a:A, _ b:B) -> String {
	
	return "A:Equatable, B:Equatable"
}

private func sameEquatableTest<A:Equatable>(a:A, _ b:A) -> String {
	
	return "A:Equatable"
}

private func sameTypeTest2<A>(a:A, _ b:A) -> String {
	
	return "A"
}

class GenericClassWhereAndSingleElementTests: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testSameType() {
	
		// 同じ型を渡したときに、選ばれるジェネリックを判定します。
		let a = 10
		let b = 20
		let c = 10.5
		
		// 同じ型を渡したときは、同じ型を想定したものが採用されるようです。
		// ただし、別々の型で条件指定がある場合には、条件が合致した関数と衝突するようです。
		XCTAssertEqual(sameTypeTest(a, b), "A")
		XCTAssertEqual(sameTypeTest(a, c), "A,B")

		// 縛ったプロトコル的には同じでも型が違えば違う方が選ばれます。
		XCTAssertEqual(sameEquatableTest(a, b), "A:Equatable")
		XCTAssertEqual(sameEquatableTest(a, c), "A:Equatable, B:Equatable")
	}

	func testAndForSingles() {
		
		let a:MyClassA = MyClassA()
		let b:MyClassB = MyClassB()
		let ab2:MyClassAB = MyClassAB()
		let c:MyClassC = MyClassC()
		let subA:MyClassSubA = MyClassSubA()
		let subB:MyClassSubB = MyClassSubB()
		let subBaseA:MySubClassBaseA = MySubClassBaseA()
		let subBaseB:MySubClassBaseB = MySubClassBaseB()
		let subBaseC:MySubClassBaseC = MySubClassBaseC()
		let sub1C:MySubClass1WithC = MySubClass1WithC()
		let sub2C:MySubClass2WithC = MySubClass2WithC()
		
		// MARK: ⭐️ a x ?
		
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
//		XCTAssertEqual(test(a, a), "A")
		XCTAssertEqual(test(a, b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolB> とが衝突する。
//		XCTAssertEqual(test(a, a2), "A,B where A:MyProtocolA, B:MyProtocolB")
		// <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
//		XCTAssertEqual(test(a, b2), "A,B where A:MyProtocolA, B:MyProtocolB")

		XCTAssertEqual(test(a, c), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a, subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(a, subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// 😱 同じクラスを基底に持つものは、同じ型として認識されるようだ。
//		XCTAssertEqual(test(a, subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(a, subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(a, subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a, sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a, sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ b x ?

		XCTAssertEqual(test(b, a), "A,B")
		XCTAssertEqual(test(b, b), "A")
		XCTAssertEqual(test(b, ab2), "A,B")
		XCTAssertEqual(test(b, c), "A,B")
		XCTAssertEqual(test(b, subA), "A,B")
		XCTAssertEqual(test(b, subB), "A,B")
		XCTAssertEqual(test(b, subBaseA), "A,B")
		
		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		// もし <A,B where A:MyProtocolA, B:MyProtocolA> みたいに合致するものがあると、衝突となる。
		XCTAssertEqual(test(b, subBaseB), "A")
		XCTAssertEqual(test(b, subBaseC), "A,B")
		XCTAssertEqual(test(b, sub1C), "A,B")
		XCTAssertEqual(test(b, sub2C), "A,B")
		
		// MARK: ⭐️ ab2 x ?
		
		XCTAssertEqual(test(ab2, a), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(ab2, b), "A,B where A:MyProtocolA, B:MyProtocolB")

		// 衝突 <A>(a:A, _ b:A), <A,B where A:MyProtocolA, B:MyProtocolA>, <A,B where A:MyProtocolA, B:MyProtocolB>
		// なぜか <A>(a:A, _ b:A) とも衝突する。プロトコルに完全合致する関数がないからか？
		// MyClassAB は A にも B にも対等に該当するので、それで明記のどれにも不完全なのだろう。
//		XCTAssertEqual(test(ab2, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")

		XCTAssertEqual(test(ab2, c), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(ab2, subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(ab2, subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")
		XCTAssertEqual(test(ab2, subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(ab2, subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(ab2, subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(ab2, sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(ab2, sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ c x ?
		
		XCTAssertEqual(test(c, a), "A,B")
		XCTAssertEqual(test(c, b), "A,B where A:MyProtocolC, B:MyProtocolB")
		// MyClassAB を相手にしていても、最初を C で縛るパターンは B しかないので衝突するものがない。
		XCTAssertEqual(test(c, ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(c, c), "A")
		XCTAssertEqual(test(c, subA), "A,B")
		XCTAssertEqual(test(c, subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(c, subBaseA), "A,B")
		// プロトコルの継承関係を考慮するとふたつ該当しても、
		XCTAssertEqual(test(c, subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")

		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		XCTAssertEqual(test(c, subBaseC), "A")
		
		XCTAssertEqual(test(c, sub1C), "A,B")
		XCTAssertEqual(test(c, sub2C), "A,B")
		
		// MARK: ⭐️ subA x ?
		
		XCTAssertEqual(test(subA, a), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subA, b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// 衝突 <A,B where A:MyProtocolA, B:MyProtocolA>, <A,B where A:MyProtocolA, B:MyProtocolB>
		// MyClassSubA は A に継承的に該当し、MyClassAB は A にも B にも対等に該当するので。
		// ただ <A>(a:A, _ b:A) とは衝突しない。系列的に MyClassSubA は迷わず A と該当するからだろう。
//		XCTAssertEqual(test(subA, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subA, c), "A,B where A:MyProtocolA, B:MyProtocolC")

		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// a, a のときと同じ。純粋に曖昧性。
//		XCTAssertEqual(test(subA, subA), "A,B where A:MyProtocolA, B:MyProtocolA")

		XCTAssertEqual(test(subA, subB), "A,B where A:MyProtocolSubA, B:MyProtocolSubB")
		XCTAssertEqual(test(subA, subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subA, subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subA, subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subA, sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subA, sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ subB x ?
		
		XCTAssertEqual(test(subB, a), "A,B")
		XCTAssertEqual(test(subB, b), "A,B")
		XCTAssertEqual(test(subB, ab2), "A,B")
		XCTAssertEqual(test(subB, c), "A,B")
		XCTAssertEqual(test(subB, subA), "A,B")
		XCTAssertEqual(test(subB, subB), "A")
		XCTAssertEqual(test(subB, subBaseA), "A,B")
		XCTAssertEqual(test(subB, subBaseB), "A,B")
		XCTAssertEqual(test(subB, subBaseC), "A,B")
		XCTAssertEqual(test(subB, sub1C), "A,B")
		XCTAssertEqual(test(subB, sub2C), "A,B")
		
		// MARK: ⭐️ subBaseA x ?
		
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// a, a のときと同じ。純粋に曖昧性。
//		XCTAssertEqual(test(subBaseA, a), "A")
		
		XCTAssertEqual(test(subBaseA, b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// 衝突 <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolB>
		// このとき <A,B>(a:A, _ b:B) は衝突しない。
		// 系列的に MyClassSubA は迷わず A と該当するからだろう。
//		XCTAssertEqual(test(subA, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
//		XCTAssertEqual(test(subBaseA, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		XCTAssertEqual(test(subBaseA, c), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA, subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subBaseA, subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")
		
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// a, a のときと同じ。純粋に曖昧性。
//		XCTAssertEqual(test(subBaseA, subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")

		XCTAssertEqual(test(subBaseA, subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subBaseA, subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA, sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA, sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")
		
		// MARK: ⭐️ subBaseB x ?
		
		XCTAssertEqual(test(subBaseB, a), "A,B")
		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		XCTAssertEqual(test(subBaseB, b), "A")
		XCTAssertEqual(test(subBaseB, ab2), "A,B")
		XCTAssertEqual(test(subBaseB, c), "A,B")
		XCTAssertEqual(test(subBaseB, subA), "A,B")
		XCTAssertEqual(test(subBaseB, subB), "A,B")
		XCTAssertEqual(test(subBaseB, subBaseA), "A,B")
		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		XCTAssertEqual(test(subBaseB, subBaseB), "A")
		XCTAssertEqual(test(subBaseB, subBaseC), "A,B")
		XCTAssertEqual(test(subBaseB, sub1C), "A,B")
		XCTAssertEqual(test(subBaseB, sub2C), "A,B")
		
		// MARK: ⭐️ subBaseC x ?
		
		XCTAssertEqual(test(subBaseC, a), "A,B")
		XCTAssertEqual(test(subBaseC, b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(subBaseC, ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(subBaseC, c), "A")
		XCTAssertEqual(test(subBaseC, subA), "A,B")
		// SubB を想定したものがあるので、B を想定したものより優先される。継承関係の通り。
		XCTAssertEqual(test(subBaseC, subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(subBaseC, subBaseA), "A,B")
		XCTAssertEqual(test(subBaseC, subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(subBaseC, subBaseC), "A")
		XCTAssertEqual(test(subBaseC, sub1C), "A,B")
		XCTAssertEqual(test(subBaseC, sub2C), "A,B")
		
		// MARK: ⭐️ sub1C x ?
		
		XCTAssertEqual(test(sub1C, a), "A,B")
		XCTAssertEqual(test(sub1C, b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C, ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C, c), "A,B")
		XCTAssertEqual(test(sub1C, subA), "A,B")
		XCTAssertEqual(test(sub1C, subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(sub1C, subBaseA), "A,B")
		XCTAssertEqual(test(sub1C, subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")

		// 😕 なぜ A ではない？
		// そう思って調べてみたら、どちらもプロトコルが示す MyProtocolC に準拠しているが、
		// sub1C は MySubClass1WithC : MyClass, ProtocolC で、subBaseC は MySubClassBaseC : MyClassC : MyProtocolC だった。
		// 型だけに着目すれば MyClass と MySubClassWithC とは関係がないので A,B になる。自然な動き。
		XCTAssertEqual(test(sub1C, subBaseC), "A,B")
		XCTAssertEqual(test(sub1C, sub1C), "A")
		// 😕 最終的な型は違うが、型が同じ型を継承しているので <A> に該当するようだ。
		XCTAssertEqual(test(sub1C, sub2C), "A")
		
		// MARK: ⭐️ sub2C x ?
		
		XCTAssertEqual(test(sub1C, a), "A,B")
		XCTAssertEqual(test(sub1C, b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C, ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C, c), "A,B")
		XCTAssertEqual(test(sub1C, subA), "A,B")
		XCTAssertEqual(test(sub1C, subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(sub1C, subBaseA), "A,B")
		XCTAssertEqual(test(sub1C, subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C, subBaseC), "A,B")
		XCTAssertEqual(test(sub1C, sub1C), "A")
		XCTAssertEqual(test(sub1C, sub2C), "A")
	}
	
	func testAndForSinglesByProtocol() {
		
		NSLog("ジェネリックの場合は、プロトコル型は Any 扱いになることの再確認です。")
		let a:MyProtocolA = MyClassA()
		let b:MyProtocolB = MyClassB()
		
		// Any の中で、両方一致か、バラバラかの判定はされる。
		XCTAssertEqual(test(a, a), "A")
		XCTAssertEqual(test(a, b), "A,B")
	}
	
    func testAndForBox() {

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
		let baseAB = Box(MySubClassBaseAB(), 0)
		let baseA = Box(MySubClassBaseA(), 0)
		let baseB = Box(MySubClassBaseB(), 0)
		let baseSubA = Box(MySubClassBaseSubA(), 0)
		let baseSubB = Box(MySubClassBaseSubB(), 0)
	}

}
