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
	
	var router: Router { get set }
	
	func present(next: Routable)
	func push(next: Routable)
	func remove(payload: RoutablePayload?)
}

public extension Routable where Self: UIViewController {
	
	func present(next: Routable) {
		guard let nextVC = next as? UIViewController else { return }
		present(nextVC, animated: true, completion: nil)
	}
	
	func push(next: Routable) {
		guard let nextVC = next as? UIViewController else { return }
		navigationController?.pushViewController(nextVC, animated: true)
	}
	
	func remove(payload: RoutablePayload?) {
		defer { if let _payload = payload { previousRoutable?.router.onReturn?(_payload) } }
		guard let navVC = navigationController else { dismiss(animated: true, completion: nil); return }
		guard let controller = navVC.viewControllers.first, self != controller else { navVC.dismiss(animated: true, completion: nil); return }
		navVC.popViewController(animated: true)
	}
}

public extension Routable where Self: UIViewController {
	
	var previousRoutable: Routable? {
		if let navVC = navigationController, navVC.topViewController != self { return navVC.topViewController as? Routable }
		var previousVC = presentingViewController
		if let vc = previousVC as? UINavigationController { previousVC = vc.topViewController }
		return previousVC as? Routable
	}
}

public extension Routable {
	
	var defaultPayload: RoutablePayload {
		return RoutablePayload(sender: self)
	}
}
