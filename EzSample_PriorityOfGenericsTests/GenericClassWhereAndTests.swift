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

// 両方の型が一致した場合に、合致します。
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

private func test<A,B where A:MyProtocolB, B:MyProtocolA>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolB, B:MyProtocolA"
}

private func test<A,B where A:MyProtocolSubB, B:MyProtocolA>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolSubB, B:MyProtocolA"
}

private func test<A,B where A:MyProtocolC, B:IntegerLiteralConvertible>(a:A, _ b:B) -> String {
	
	return "A,B where A:MyProtocolC, IntegerLiteralConvertible"
}

private func test<A where A:MyProtocolC>(a:A, _ b:Double) -> String {
	
	return "A,B where A:MyProtocolC, B==Double"
}

private func test<A where A:MyProtocolA>(a:A, _ b:String) -> String {
	
	return "A,B where A:MyProtocolA, B==String"
}

private func test<A where A:MyProtocolC>(a:A, _ b:String) -> String {
	
	return "A,B where A:MyProtocolC, B==String"
}

//private func test<A,B where A:MyProtocolC, B:FloatLiteralConvertible>(a:A, _ b:B) -> String {
//	
//	return "A,B where A:MyProtocolC, B:FloatLiteralConvertible"
//}

private func test<X:BoxProtocol where X.A == X.B>(a:X) -> String {
	
	return "A"
}

private func test<X:BoxProtocol>(a:X) -> String {
	
	return "A,B"
}


private func test<X:BoxProtocol where X.A:MyProtocolA, X.B:MyProtocolA>(a:X) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolA"
}

private func test<X:BoxProtocol where X.A:MyProtocolA, X.B:MyProtocolB>(a:X) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolB"
}

private func test<X:BoxProtocol where X.A:MyProtocolA, X.B:MyProtocolC>(a:X) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolC"
}

private func test<X:BoxProtocol where X.A:MyProtocolSubA, X.B:MyProtocolSubB>(a:X) -> String {
	
	return "A,B where A:MyProtocolSubA, B:MyProtocolSubB"
}

private func test<X:BoxProtocol where X.A:MyProtocolA, X.B:MyProtocolSubB>(a:X) -> String {
	
	return "A,B where A:MyProtocolA, B:MyProtocolSubB"
}

private func test<X:BoxProtocol where X.A:MyProtocolB, X.B:MyProtocolA>(a:X) -> String {
	
	return "A,B where A:MyProtocolB, B:MyProtocolA"
}

private func test<X:BoxProtocol where X.A:MyProtocolSubB, X.B:MyProtocolA>(a:X) -> String {
	
	return "A,B where A:MyProtocolSubB, B:MyProtocolA"
}

private func test<X:BoxProtocol where X.A:MyProtocolC, X.B:MyProtocolB>(a:X) -> String {
	
	return "A,B where A:MyProtocolC, B:MyProtocolB"
}

private func test<X:BoxProtocol where X.A:MyProtocolC, X.B:MyProtocolSubB>(a:X) -> String {
	
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
//		XCTAssertEqual(test(a, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
		// <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
//		XCTAssertEqual(test(a, bb2), "A,B where A:MyProtocolA, B:MyProtocolB")

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

		XCTAssertEqual(test(b, a), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b, b), "A")
		XCTAssertEqual(test(b, ab2), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b, c), "A,B")
		XCTAssertEqual(test(b, subA), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b, subB), "A,B")
		XCTAssertEqual(test(b, subBaseA), "A,B where A:MyProtocolB, B:MyProtocolA")
		
		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		// もし <A,B where A:MyProtocolA, B:MyProtocolA> みたいに合致するものがあると、衝突となる。
		XCTAssertEqual(test(b, subBaseB), "A")
		XCTAssertEqual(test(b, subBaseC), "A,B")
		XCTAssertEqual(test(b, sub1C), "A,B")
		XCTAssertEqual(test(b, sub2C), "A,B")
		
		// MARK: ⭐️ ab2 x ?
		
		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2, a), "A,B where A:MyProtocolA, B:MyProtocolA")
		
		XCTAssertEqual(test(ab2, b), "A,B where A:MyProtocolA, B:MyProtocolB")

		// 衝突 <A>(a:A, _ b:A), <A,B where A:MyProtocolA, B:MyProtocolA>, <A,B where A:MyProtocolA, B:MyProtocolB>
		// なぜか <A>(a:A, _ b:A) とも衝突する。プロトコルに完全合致する関数がないからか？
		// MyClassAB は A にも B にも対等に該当するので、それで明記のどれにも不完全なのだろう。
//		XCTAssertEqual(test(ab2, ab2), "A,B where A:MyProtocolA, B:MyProtocolB")

		XCTAssertEqual(test(ab2, c), "A,B where A:MyProtocolA, B:MyProtocolC")

		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2, subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		
		XCTAssertEqual(test(ab2, subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")

		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2, subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")

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
		
		// 本来の型にちゃんとはめている場合、SubB と B がある場合、SubB とみなす。
		XCTAssertEqual(test(subB, a), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB, b), "A,B")
		XCTAssertEqual(test(subB, ab2), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB, c), "A,B")
		XCTAssertEqual(test(subB, subA), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB, subB), "A")
		XCTAssertEqual(test(subB, subBaseA), "A,B where A:MyProtocolSubB, B:MyProtocolA")
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
		
		XCTAssertEqual(test(subBaseB, a), "A,B where A:MyProtocolB, B:MyProtocolA")
		// 😕 同じクラスを基底に持つものは、同じ型として認識されるようだ。
		// つまり、プロトコルと違って同一視できる。
		XCTAssertEqual(test(subBaseB, b), "A")
		XCTAssertEqual(test(subBaseB, ab2), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(subBaseB, c), "A,B")
		XCTAssertEqual(test(subBaseB, subA), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(subBaseB, subB), "A,B")
		XCTAssertEqual(test(subBaseB, subBaseA), "A,B where A:MyProtocolB, B:MyProtocolA")
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
	
	func testInheritance() {
		
		let a:MyClassA = MyClassA()
		let subBaseBWithC:MySubClassBWithC = MySubClassBWithC()
		let subBaseBWithCAsB:MyClassB = MySubClassBWithC()

		let subBaseAWithC:MySubClassAWithC = MySubClassAWithC()
		let subBaseAWithCAsA:MyClassA = MySubClassAWithC()

		// 😕 継承の深さが違っても、subBaseBWithC を持ってる。
		// <A,B where A:MyProtocolB, B:MyProtocolC> と <A,B where A:MyProtocolA, B:MyProtocolC> とで衝突している。
//		XCTAssertEqual(test(a, subBaseBWithC), "A,B")
		
		// 😕 継承の深さが違っても、subBaseBWithC を持ってる。
		// ただ、入れる型が MySubClassBWithC ではなく MyClassB になるため、
		// 衝突しなくなる。つまり、型に依存。
		XCTAssertEqual(test(a, subBaseBWithCAsB), "A,B where A:MyProtocolA, B:MyProtocolB")

		// 😧 型継承とプロトコルの場合、もしかして基底の型がもつプロトコルは型の一部ともなされ、優先度がたかい？
		// 親がもつ B が優先され、直指定の型が持つ C は無視された。
		// と思ったが、C, A というパターンは作っていなかった。作ると両者が曖昧になる。
		// つまり C ではなく B として合致する。
		XCTAssertEqual(test(subBaseBWithC, a), "A,B where A:MyProtocolB, B:MyProtocolA")

		// こちらは型を B にキャストしているので B, A になって良い。
		XCTAssertEqual(test(subBaseBWithCAsB, a), "A,B where A:MyProtocolB, B:MyProtocolA")

		// 親クラスが合致する関数がなければ、子のクラスもつプロトコルが合致する。
		XCTAssertEqual(test(subBaseAWithC, 1), "A,B where A:MyProtocolC, IntegerLiteralConvertible")
		// 親にキャストすると C に準拠している情報が抜けるため、無条件 A,B に合致する。
		XCTAssertEqual(test(subBaseAWithCAsA, 1), "A,B")

		// Double にすれば型完全一致が優先される。IntegerLiteralConvertible は無視された。
		XCTAssertEqual(test(subBaseAWithC, Double(1.5)), "A,B where A:MyProtocolC, B==Double")
		// 親にキャストすると C に準拠している情報が抜けるため、無条件 A,B に合致する。
		XCTAssertEqual(test(subBaseAWithCAsA, Double(1.5)), "A,B")
		
		// Double にすれば型完全一致が優先される。IntegerLiteralConvertible は無視された。
		// 😧 右側を String 固定で、左側を A と C にしたとき、曖昧になった。
		// プロトコルでキャストすると、プロトコル型はジェネリックで加味されない性質により A,B になります。
		XCTAssertEqual(test(subBaseAWithC as MyProtocolA, String("")), "A,B")
		XCTAssertEqual(test(subBaseAWithC as MyProtocolC, String("")), "A,B")
		// 型でキャストすれば、期待通りの判定になります。切り替わります。
		XCTAssertEqual(test(subBaseAWithC as MyClassA, String("")), "A,B where A:MyProtocolA, B==String")

		// 親にキャストすると C に準拠している情報が抜けるため A 側に合致する。
		XCTAssertEqual(test(subBaseAWithCAsA, String("")), "A,B where A:MyProtocolA, B==String")
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

		let a_a = Box(a, a)
		let a_b = Box(a, b)
		let a_ab2 = Box(a, ab2)
		let a_c = Box(a, c)
		let a_subA = Box(a, subA)
		let a_subB = Box(a, subB)
		let a_subBaseA = Box(a, subBaseA)
		let a_subBaseB = Box(a, subBaseB)
		let a_subBaseC = Box(a, subBaseC)
		let a_sub1C = Box(a, sub1C)
		let a_sub2C = Box(a, sub2C)
		
		let b_a = Box(b, a)
		let b_b = Box(b, b)
		let b_ab2 = Box(b, ab2)
		let b_c = Box(b, c)
		let b_subA = Box(b, subA)
		let b_subB = Box(b, subB)
		let b_subBaseA = Box(b, subBaseA)
		let b_subBaseB = Box(b, subBaseB)
		let b_subBaseC = Box(b, subBaseC)
		let b_sub1C = Box(b, sub1C)
		let b_sub2C = Box(b, sub2C)
		
		let ab2_a = Box(ab2, a)
		let ab2_b = Box(ab2, b)
		let ab2_ab2 = Box(ab2, ab2)
		let ab2_c = Box(ab2, c)
		let ab2_subA = Box(ab2, subA)
		let ab2_subB = Box(ab2, subB)
		let ab2_subBaseA = Box(ab2, subBaseA)
		let ab2_subBaseB = Box(ab2, subBaseB)
		let ab2_subBaseC = Box(ab2, subBaseC)
		let ab2_sub1C = Box(ab2, sub1C)
		let ab2_sub2C = Box(ab2, sub2C)
		
		let c_a = Box(c, a)
		let c_b = Box(c, b)
		let c_ab2 = Box(c, ab2)
		let c_c = Box(c, c)
		let c_subA = Box(c, subA)
		let c_subB = Box(c, subB)
		let c_subBaseA = Box(c, subBaseA)
		let c_subBaseB = Box(c, subBaseB)
		let c_subBaseC = Box(c, subBaseC)
		let c_sub1C = Box(c, sub1C)
		let c_sub2C = Box(c, sub2C)
		
		let subA_a = Box(subA, a)
		let subA_b = Box(subA, b)
		let subA_ab2 = Box(subA, ab2)
		let subA_c = Box(subA, c)
		let subA_subA = Box(subA, subA)
		let subA_subB = Box(subA, subB)
		let subA_subBaseA = Box(subA, subBaseA)
		let subA_subBaseB = Box(subA, subBaseB)
		let subA_subBaseC = Box(subA, subBaseC)
		let subA_sub1C = Box(subA, sub1C)
		let subA_sub2C = Box(subA, sub2C)
		
		let subB_a = Box(subB, a)
		let subB_b = Box(subB, b)
		let subB_ab2 = Box(subB, ab2)
		let subB_c = Box(subB, c)
		let subB_subA = Box(subB, subA)
		let subB_subB = Box(subB, subB)
		let subB_subBaseA = Box(subB, subBaseA)
		let subB_subBaseB = Box(subB, subBaseB)
		let subB_subBaseC = Box(subB, subBaseC)
		let subB_sub1C = Box(subB, sub1C)
		let subB_sub2C = Box(subB, sub2C)
		
		let subBaseA_a = Box(subBaseA, a)
		let subBaseA_b = Box(subBaseA, b)
		let subBaseA_ab2 = Box(subBaseA, ab2)
		let subBaseA_c = Box(subBaseA, c)
		let subBaseA_subA = Box(subBaseA, subA)
		let subBaseA_subB = Box(subBaseA, subB)
		let subBaseA_subBaseA = Box(subBaseA, subBaseA)
		let subBaseA_subBaseB = Box(subBaseA, subBaseB)
		let subBaseA_subBaseC = Box(subBaseA, subBaseC)
		let subBaseA_sub1C = Box(subBaseA, sub1C)
		let subBaseA_sub2C = Box(subBaseA, sub2C)
		
		let subBaseB_a = Box(subBaseB, a)
		let subBaseB_b = Box(subBaseB, b)
		let subBaseB_ab2 = Box(subBaseB, ab2)
		let subBaseB_c = Box(subBaseB, c)
		let subBaseB_subA = Box(subBaseB, subA)
		let subBaseB_subB = Box(subBaseB, subB)
		let subBaseB_subBaseA = Box(subBaseB, subBaseA)
		let subBaseB_subBaseB = Box(subBaseB, subBaseB)
		let subBaseB_subBaseC = Box(subBaseB, subBaseC)
		let subBaseB_sub1C = Box(subBaseB, sub1C)
		let subBaseB_sub2C = Box(subBaseB, sub2C)
		
		let subBaseC_a = Box(subBaseC, a)
		let subBaseC_b = Box(subBaseC, b)
		let subBaseC_ab2 = Box(subBaseC, ab2)
		let subBaseC_c = Box(subBaseC, c)
		let subBaseC_subA = Box(subBaseC, subA)
		let subBaseC_subB = Box(subBaseC, subB)
		let subBaseC_subBaseA = Box(subBaseC, subBaseA)
		let subBaseC_subBaseB = Box(subBaseC, subBaseB)
		let subBaseC_subBaseC = Box(subBaseC, subBaseC)
		let subBaseC_sub1C = Box(subBaseC, sub1C)
		let subBaseC_sub2C = Box(subBaseC, sub2C)
		
		let sub1C_a = Box(sub1C, a)
		let sub1C_b = Box(sub1C, b)
		let sub1C_ab2 = Box(sub1C, ab2)
		let sub1C_c = Box(sub1C, c)
		let sub1C_subA = Box(sub1C, subA)
		let sub1C_subB = Box(sub1C, subB)
		let sub1C_subBaseA = Box(sub1C, subBaseA)
		let sub1C_subBaseB = Box(sub1C, subBaseB)
		let sub1C_subBaseC = Box(sub1C, subBaseC)
		let sub1C_sub1C = Box(sub1C, sub1C)
		let sub1C_sub2C = Box(sub1C, sub2C)
		
		let sub2C_a = Box(sub2C, a)
		let sub2C_b = Box(sub2C, b)
		let sub2C_ab2 = Box(sub2C, ab2)
		let sub2C_c = Box(sub2C, c)
		let sub2C_subA = Box(sub2C, subA)
		let sub2C_subB = Box(sub2C, subB)
		let sub2C_subBaseA = Box(sub2C, subBaseA)
		let sub2C_subBaseB = Box(sub2C, subBaseB)
		let sub2C_subBaseC = Box(sub2C, subBaseC)
		let sub2C_sub1C = Box(sub2C, sub1C)
		let sub2C_sub2C = Box(sub2C, sub2C)
		
		
		// MARK: ⭐️ a x ?
		
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
//		XCTAssertEqual(test(a_a), "A")
		XCTAssertEqual(test(a_b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolB> とが衝突する。
//		XCTAssertEqual(test(a_ab2), "A,B where A:MyProtocolA, B:MyProtocolB")

		XCTAssertEqual(test(a_c), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a_subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(a_subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")
		// 😱 変数同士のときは <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// 😱 変数同士では、同じクラスを基底に持つものは、同じ型として認識されるようだったが、
		// ひとつに混ぜるとそうではなくなったので、衝突しなくなった。
		XCTAssertEqual(test(a_subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(a_subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(a_subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a_sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(a_sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ b x ?

		XCTAssertEqual(test(b_a), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b_b), "A")
		XCTAssertEqual(test(b_ab2), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b_c), "A,B")
		XCTAssertEqual(test(b_subA), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(b_subB), "A,B")
		XCTAssertEqual(test(b_subBaseA), "A,B where A:MyProtocolB, B:MyProtocolA")
		
		// 😦 独立した２つの型であれば、同じクラスを基底に持つものは、同じ型として認識されるようだったが、
		// 一つの型に収めると、違う型として判断されるようになるようだ。
		// つまり、プロトコルと違って同一視できない。
		// ジェネリックで指定した A を引数で判定する型 A, A と where A == B は別物。
		// 前者は継承関係も見て一致させる、後者は完全一致を目指す。
		// 😦😦これも、引数の型明記が優先のルールかもしれない。少し無理はある。
		// 引数的に「型」判定なので、継承関係もみて判定する。
		// where のときは、条件として型が一致しているか判定。
		// 通常なら、いっけん継承が考慮されると思われるが、それは引数のところで考慮されていて、ジェネリックでは完全一致、そう捉えると筋は通る。理解は難しい。
		XCTAssertEqual(test(b_subBaseB), "A,B")
		XCTAssertEqual(test(b_subBaseC), "A,B")
		XCTAssertEqual(test(b_sub1C), "A,B")
		XCTAssertEqual(test(b_sub2C), "A,B")
		
		// MARK: ⭐️ ab2 x ?
		
		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2_a), "A,B where A:MyProtocolA, B:MyProtocolA")
		
		XCTAssertEqual(test(ab2_b), "A,B where A:MyProtocolA, B:MyProtocolB")

		// 衝突 <A>(a:A, _ b:A), <A,B where A:MyProtocolA, B:MyProtocolA>, <A,B where A:MyProtocolA, B:MyProtocolB>
		// なぜか <A>(a:A, _ b:A) とも衝突する。プロトコルに完全合致する関数がないからか？
		// MyClassAB は A にも B にも対等に該当するので、それで明記のどれにも不完全なのだろう。
//		XCTAssertEqual(test(ab2_ab2), "A,B where A:MyProtocolA, B:MyProtocolB")

		XCTAssertEqual(test(ab2_c), "A,B where A:MyProtocolA, B:MyProtocolC")

		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2_subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		
		XCTAssertEqual(test(ab2_subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")

		// <A,A> と <B,A> の両方に合致する可能性があります。
//		XCTAssertEqual(test(ab2_subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")

		XCTAssertEqual(test(ab2_subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(ab2_subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(ab2_sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(ab2_sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ c x ?
		
		XCTAssertEqual(test(c_a), "A,B")
		XCTAssertEqual(test(c_b), "A,B where A:MyProtocolC, B:MyProtocolB")
		// MyClassAB を相手にしていても、最初を C で縛るパターンは B しかないので衝突するものがない。
		XCTAssertEqual(test(c_ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(c_c), "A")
		XCTAssertEqual(test(c_subA), "A,B")
		XCTAssertEqual(test(c_subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(c_subBaseA), "A,B")
		// プロトコルの継承関係を考慮するとふたつ該当しても、
		XCTAssertEqual(test(c_subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")

		// 😦 独立した２つの型であれば、同じクラスを基底に持つものは、同じ型として認識されるようだったが、
		// 一つの型に収めると、違う型として判断されるようになるようだ。
		// つまり、プロトコルと違って同一視できない。
		// ジェネリックで指定した A を引数で判定する型 A, A と where A == B は別物。
		// 前者は継承関係も見て一致させる、後者は完全一致を目指す。
		// 😦😦これも、引数の型明記が優先のルールかもしれない。少し無理はある。
		// 引数的に「型」判定なので、継承関係もみて判定する。
		// where のときは、条件として型が一致しているか判定。
		// 通常なら、いっけん継承が考慮されると思われるが、それは引数のところで考慮されていて、ジェネリックでは完全一致、そう捉えると筋は通る。理解は難しい。
		XCTAssertEqual(test(c_subBaseC), "A,B")
		
		XCTAssertEqual(test(c_sub1C), "A,B")
		XCTAssertEqual(test(c_sub2C), "A,B")
		
		// MARK: ⭐️ subA x ?
		
		XCTAssertEqual(test(subA_a), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subA_b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// 衝突 <A,B where A:MyProtocolA, B:MyProtocolA>, <A,B where A:MyProtocolA, B:MyProtocolB>
		// MyClassSubA は A に継承的に該当し、MyClassAB は A にも B にも対等に該当するので。
		// ただ <A>(a:A, _ b:A) とは衝突しない。系列的に MyClassSubA は迷わず A と該当するからだろう。
//		XCTAssertEqual(test(subA_ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subA_c), "A,B where A:MyProtocolA, B:MyProtocolC")

		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// a, a のときと同じ。純粋に曖昧性。
//		XCTAssertEqual(test(subA_subA), "A,B where A:MyProtocolA, B:MyProtocolA")

		XCTAssertEqual(test(subA_subB), "A,B where A:MyProtocolSubA, B:MyProtocolSubB")
		XCTAssertEqual(test(subA_subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subA_subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subA_subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subA_sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subA_sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")

		// MARK: ⭐️ subB x ?
		
		// 本来の型にちゃんとはめている場合、SubB と B がある場合、SubB とみなす。
		XCTAssertEqual(test(subB_a), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB_b), "A,B")
		XCTAssertEqual(test(subB_ab2), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB_c), "A,B")
		XCTAssertEqual(test(subB_subA), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB_subB), "A")
		XCTAssertEqual(test(subB_subBaseA), "A,B where A:MyProtocolSubB, B:MyProtocolA")
		XCTAssertEqual(test(subB_subBaseB), "A,B")
		XCTAssertEqual(test(subB_subBaseC), "A,B")
		XCTAssertEqual(test(subB_sub1C), "A,B")
		XCTAssertEqual(test(subB_sub2C), "A,B")
		
		// MARK: ⭐️ subBaseA x ?
		
		// 😕これもひとつの型に包んだことによる、違う型と判定される例。
		// ふたつの変数同士のときは、<A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突していた。
		// A,B where A:MyProtocolA, B:MyProtocolA と合致するため、結果は A,B ではなくそれになっている。
		XCTAssertEqual(test(subBaseA_a), "A,B where A:MyProtocolA, B:MyProtocolA")
		
		XCTAssertEqual(test(subBaseA_b), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		// 衝突 <A,B where A:MyProtocolA, B:MyProtocolA> と <A,B where A:MyProtocolA, B:MyProtocolB>
		// このとき <A,B>(a:A, _ b:B) は衝突しない。
		// 系列的に MyClassSubA は迷わず A と該当するからだろう。
//		XCTAssertEqual(test(subA_ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
//		XCTAssertEqual(test(subBaseA_ab2), "A,B where A:MyProtocolA, B:MyProtocolB")
		
		XCTAssertEqual(test(subBaseA_c), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA_subA), "A,B where A:MyProtocolA, B:MyProtocolA")
		XCTAssertEqual(test(subBaseA_subB), "A,B where A:MyProtocolA, B:MyProtocolSubB")
		
		// <A> と <A,B where A:MyProtocolA, B:MyProtocolA> とが衝突する。
		// a, a のときと同じ。純粋に曖昧性。
//		XCTAssertEqual(test(subBaseA_subBaseA), "A,B where A:MyProtocolA, B:MyProtocolA")

		XCTAssertEqual(test(subBaseA_subBaseB), "A,B where A:MyProtocolA, B:MyProtocolB")
		XCTAssertEqual(test(subBaseA_subBaseC), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA_sub1C), "A,B where A:MyProtocolA, B:MyProtocolC")
		XCTAssertEqual(test(subBaseA_sub2C), "A,B where A:MyProtocolA, B:MyProtocolC")
		
		// MARK: ⭐️ subBaseB x ?
		
		XCTAssertEqual(test(subBaseB_a), "A,B where A:MyProtocolB, B:MyProtocolA")
		// 😦 独立した２つの型であれば、同じクラスを基底に持つものは、同じ型として認識されるようだったが、
		// 一つの型に収めると、違う型として判断されるようになるようだ。
		// つまり、プロトコルと違って同一視できない。
		// ジェネリックで指定した A を引数で判定する型 A, A と where A == B は別物。
		// 前者は継承関係も見て一致させる、後者は完全一致を目指す。
		// 😦😦これも、引数の型明記が優先のルールかもしれない。少し無理はある。
		// 引数的に「型」判定なので、継承関係もみて判定する。
		// where のときは、条件として型が一致しているか判定。
		// 通常なら、いっけん継承が考慮されると思われるが、それは引数のところで考慮されていて、ジェネリックでは完全一致、そう捉えると筋は通る。理解は難しい。
		XCTAssertEqual(test(subBaseB_b), "A,B")
		XCTAssertEqual(test(subBaseB_ab2), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(subBaseB_c), "A,B")
		XCTAssertEqual(test(subBaseB_subA), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(subBaseB_subB), "A,B")
		XCTAssertEqual(test(subBaseB_subBaseA), "A,B where A:MyProtocolB, B:MyProtocolA")
		XCTAssertEqual(test(subBaseB_subBaseB), "A")
		XCTAssertEqual(test(subBaseB_subBaseC), "A,B")
		XCTAssertEqual(test(subBaseB_sub1C), "A,B")
		XCTAssertEqual(test(subBaseB_sub2C), "A,B")
		
		// MARK: ⭐️ subBaseC x ?
		
		XCTAssertEqual(test(subBaseC_a), "A,B")
		XCTAssertEqual(test(subBaseC_b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(subBaseC_ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		// 😕これもひとつの型に包んだことによる、違う型と判定される例。
		XCTAssertEqual(test(subBaseC_c), "A,B")
		XCTAssertEqual(test(subBaseC_subA), "A,B")
		// SubB を想定したものがあるので、B を想定したものより優先される。継承関係の通り。
		XCTAssertEqual(test(subBaseC_subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(subBaseC_subBaseA), "A,B")
		XCTAssertEqual(test(subBaseC_subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(subBaseC_subBaseC), "A")
		XCTAssertEqual(test(subBaseC_sub1C), "A,B")
		XCTAssertEqual(test(subBaseC_sub2C), "A,B")
		
		// MARK: ⭐️ sub1C x ?
		
		XCTAssertEqual(test(sub1C_a), "A,B")
		XCTAssertEqual(test(sub1C_b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C_ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C_c), "A,B")
		XCTAssertEqual(test(sub1C_subA), "A,B")
		XCTAssertEqual(test(sub1C_subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(sub1C_subBaseA), "A,B")
		XCTAssertEqual(test(sub1C_subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")

		// 😚ボックスに入れない時と同じ動き。
		// なぜ A ではない？
		// そう思って調べてみたら、どちらもプロトコルが示す MyProtocolC に準拠しているが、
		// sub1C は MySubClass1WithC : MyClass, ProtocolC で、subBaseC は MySubClassBaseC : MyClassC : MyProtocolC だった。
		// 型だけに着目すれば MyClass と MySubClassWithC とは関係がないので A,B になる。自然な動き。
		XCTAssertEqual(test(sub1C_subBaseC), "A,B")
		XCTAssertEqual(test(sub1C_sub1C), "A")
		// 😕 変数ふたつの時は『最終的な型は違うが、型が同じ型を継承しているので <A> に該当するようだ』ったが、ひとつに収めると別物となる。
		// 😕これもひとつの型に包んだことによる、違う型と判定される例。
		XCTAssertEqual(test(sub1C_sub2C), "A,B")
		
		// MARK: ⭐️ sub2C x ?
		
		XCTAssertEqual(test(sub1C_a), "A,B")
		XCTAssertEqual(test(sub1C_b), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C_ab2), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C_c), "A,B")
		XCTAssertEqual(test(sub1C_subA), "A,B")
		XCTAssertEqual(test(sub1C_subB), "A,B where A:MyProtocolC, B:MyProtocolSubB")
		XCTAssertEqual(test(sub1C_subBaseA), "A,B")
		XCTAssertEqual(test(sub1C_subBaseB), "A,B where A:MyProtocolC, B:MyProtocolB")
		XCTAssertEqual(test(sub1C_subBaseC), "A,B")
		XCTAssertEqual(test(sub1C_sub1C), "A")
		
		// 😕これもひとつの型に包んだことによる、違う型と判定される例。
		XCTAssertEqual(test(sub1C_sub2C), "A,B")
	}

}
