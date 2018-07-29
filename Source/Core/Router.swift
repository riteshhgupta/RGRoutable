//
//  Router.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation

public typealias RouteHandler = ((RoutablePayload) -> Void)

public class Router {
	
	public var onNext: RouteHandler?
	public var onReturn: RouteHandler?
	public var onComplete: RouteHandler
	
	public init(
		onNext: RouteHandler? = nil,
		onReturn: RouteHandler? = nil,
		onComplete: @escaping RouteHandler = Router.onComplete)
	{
		self.onNext = onNext
		self.onComplete = onComplete
		self.onReturn = onReturn
	}
	
	public static var onComplete: RouteHandler {
		return { $0.sender?.remove(payload: $0, animated: true, completion: nil) }
	}
}
