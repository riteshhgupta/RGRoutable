//
//  ViewController.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import UIKit
import ReactiveSwift

class HomeViewController: UIViewController {

	let router = Router()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		router.onReturn = { print("Here you can catch any in-coming data when returning from another screen = \($0)") }
	}

	@IBAction func didTapSettingsButton(_ sender: UIButton) {
		let payload = routablePayload(data: Route.settings)
		router.onNext?(payload)
	}

	@IBAction func didTapProfileButton(_ sender: UIButton) {
		let payload = routablePayload(data: Route.profile)
		router.onNext?(payload)
	}
}

extension HomeViewController: Routable {}

extension HomeViewController {

	enum Route: RoutableData {
		case settings
		case profile
	}
}
