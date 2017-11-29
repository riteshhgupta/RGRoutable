//
//  ViewController.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import UIKit
import ReactiveSwift

class ViewController: UIViewController {

	private var _router: Router!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		let paylaod = MutableProperty<RoutablePayload?>(nil)
		router = Router()
		router.reactive.onNext <~ paylaod.producer.skipNil()
		router.reactive.onNextSignal.observeValues { print($0) }
		paylaod.value = RoutablePayload(sender: self)
		paylaod.value = RoutablePayload(sender: self)
		paylaod.value = RoutablePayload(sender: self)
	}
}

extension ViewController: Routable {
	
	var router: Router {
		get { return _router }
		set { _router = newValue }
	}
}
