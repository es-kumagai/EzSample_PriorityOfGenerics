//
//  MyClass.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/08.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

class MyClass {
	
	var value:String
	
	init(_ value:String) {
		
		self.value = value
	}
	
	convenience init() {
		
		self.init("MyClass")
	}
}

class MyClassA : MyProtocolA {
	
}

class MyClassB : MyProtocolB {
	
}

class MyClassC : MyProtocolC {
	
}

class MyClassSubA : MyProtocolSubA {
	
}

class MyClassSubB : MyProtocolSubB {
	
}

class MyClassAB : MyProtocolA, MyProtocolB {
	
}

class MySubClass : MyClass {

}

class MySubClass1WithC : MyClass, MyProtocolC {
	
}

class MySubClass2WithC : MyClass, MyProtocolC {
	
}

class MySubClassAWithC : MyClassA, MyProtocolC {
	
}

class MySubClassBWithC : MyClassB, MyProtocolC {
	
}

class MySubClassBaseA : MyClassA {
	
}

class MySubClassBaseB : MyClassB {
	
}

class MySubClassBaseC : MyClassC {
	
}

class MySubClassBaseAB : MyClassAB {
	
}

class MySubClassBaseSubA : MyClassSubA {
	
}

class MySubClassBaseSubB : MyClassSubB {
	
}

// 構造体同様、同一の型が継承済みのプロトコルを明記しても問題ない。
class MyClassASubA : MyProtocolA, MyProtocolSubA {
	
}

// ただし、クラス継承の先で、既に継承済みのプロトコルを指定すると Redundant 冗長エラー。
//class MySubClassABaseSubA : MyClassSubA, MyProtocolA {
//	
//}
//
//class MySubClassABaseSubB : MyClassSubB, MyProtocolB {
//	
//}
