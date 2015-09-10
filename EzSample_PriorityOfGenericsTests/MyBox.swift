//
//  MyBox.swift
//  EzSample_PriorityOfGenerics
//
//  Created by Tomohiro Kumagai on H27/09/10.
//  Copyright © 平成27年 EasyStyle G.K. All rights reserved.
//

protocol BoxProtocol {

	typealias A
	typealias B
	
	var a:A { get }
	var b:B { get }
}

struct Box<A, B> : BoxProtocol {
	
	var a:A
	var b:B
	
	init(_ a:A, _ b:B) {
		
		self.a = a
		self.b = b
	}
}

struct Box2<A, B> : BoxProtocol {
	
	var a:A
	var b:B
	
	init(_ a:A, _ b:B) {
		
		self.a = a
		self.b = b
	}
}

class CBox<A, B> : BoxProtocol {
	
	var a:A
	var b:B
	
	init(_ a:A, _ b:B) {
		
		self.a = a
		self.b = b
	}
}

class CBox2<A, B> : BoxProtocol {
	
	var a:A
	var b:B
	
	init(_ a:A, _ b:B) {
		
		self.a = a
		self.b = b
	}
}
