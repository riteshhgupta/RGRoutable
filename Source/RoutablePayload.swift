//
//  RoutablePayload.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation

public final class RoutablePayload {
	
	public let data: RoutableData?
	public weak var sender: Routable?
	
	public init(data: RoutableData? = nil, sender: Routable) {
		self.data = data
		self.sender = sender
	}
}
