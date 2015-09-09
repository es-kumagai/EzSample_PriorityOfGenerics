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