//
//  MyStruct.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/08.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

struct MyStruct {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStruct")
	}
}

struct MyEquatableStruct : Equatable {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyEquatableStruct")
	}
}

func == (lhs:MyEquatableStruct, rhs:MyEquatableStruct) -> Bool {
	
	return lhs.value == rhs.value
}

struct MyComparableStruct : Comparable {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyComparableStruct")
	}
}

func == (lhs:MyComparableStruct, rhs:MyComparableStruct) -> Bool {
	
	return lhs.value == rhs.value
}

func < (lhs:MyComparableStruct, rhs:MyComparableStruct) -> Bool {
	
	return lhs.value == rhs.value
}

struct MyStructA : MyProtocolA {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructA")
	}
}

struct MyStructB : MyProtocolB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructB")
	}
}

struct MyStructSubA : MyProtocolSubA {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructSubA")
	}
}

struct MyStructSubB : MyProtocolSubB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructSubB")
	}
}

struct MyStructAC : MyProtocolA, MyProtocolC {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructAC")
	}
}

struct MyStructBC : MyProtocolB, MyProtocolC {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructBC")
	}
}

struct MyStructSubAC : MyProtocolSubA, MyProtocolC {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructSubAC")
	}
}

struct MyStructSubBC : MyProtocolSubB, MyProtocolC {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructSubBC")
	}
}

struct MyStructAB : MyProtocolA, MyProtocolB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructAB")
	}
}

struct MyStructSubASubB : MyProtocolSubA, MyProtocolSubB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructSubASubB")
	}
}

struct MyStructASubA : MyProtocolA, MyProtocolSubA {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructASubA")
	}
}


struct MyStructBSubB : MyProtocolB, MyProtocolSubB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructBSubB")
	}
}

struct MyStructASubB : MyProtocolA, MyProtocolSubB {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructASubA")
	}
}


struct MyStructBSubA : MyProtocolB, MyProtocolSubA {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	init() {
		
		self.init("MyStructBSubB")
	}
}
