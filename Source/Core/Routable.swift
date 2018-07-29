//
//  Routable.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

public protocol Routable: class {
	
	var router: Router { get }
	
	func push(next: Routable, animated: Bool)
	func present(next: Routable, animated: Bool, completion handler: (() -> Void)?)
	func remove(payload: RoutablePayload?, animated: Bool, completion handler: (() -> Void)?)
	func removeNavigationStack(payload: RoutablePayload?, animated: Bool, completion handler: (() -> Void)?)
}

public extension Routable where Self: UIViewController {
	
	func present(next: Routable, animated: Bool, completion handler: (() -> Void)?) {
		guard let nextVC = next as? UIViewController else { return }
		present(nextVC, animated: animated, completion: handler)
	}
	
	func push(next: Routable, animated: Bool) {
		guard let nextVC = next as? UIViewController else { return }
		navigationController?.pushViewController(nextVC, animated: animated)
	}
	
	func remove(payload: RoutablePayload?, animated: Bool, completion handler: (() -> Void)?) {
		defer { if let _payload = payload { previousRoutable?.router.onReturn?(_payload) } }
		guard let navVC = navigationController else { dismiss(animated: animated, completion: handler); return }
		guard let controller = navVC.viewControllers.first, self != controller else { navVC.dismiss(animated: animated, completion: handler); return }
		navVC.popViewController(animated: animated)
	}

	func removeNavigationStack(payload: RoutablePayload?, animated: Bool, completion handler: (() -> Void)?) {
		var parentVC = navigationController?.presentingViewController as? Routable
		if let navVC = parentVC as? UINavigationController { parentVC = navVC.topViewController as? Routable }
		if let navVC = navigationController { navVC.dismiss(animated: animated, completion: handler) }
		defer { if let _payload = payload { parentVC?.router.onReturn?(_payload) } }
	}
}

extension Routable where Self: UIViewController {
	
	var previousRoutable: Routable? {
		if let navVC = navigationController, navVC.topViewController != self { return navVC.topViewController as? Routable }
		var previousVC = presentingViewController
		if let vc = previousVC as? UINavigationController { previousVC = vc.topViewController }
		return previousVC as? Routable
	}
}

public extension Routable {

	public func routablePayload(data: RoutableData? = nil) -> RoutablePayload {
		return RoutablePayload(data: data, sender: self)
	}
}
