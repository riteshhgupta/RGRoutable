//
//  SettingsViewController.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 16/05/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

final class SettingsViewController: UIViewController {

	let router = Router()

	override func viewDidLoad() {
		super.viewDidLoad()
		router.onReturn = {
			print("Coming to SettingsViewController from \(String(describing: $0.sender))")
		}
	}

	@IBAction func didTapDismissButton(_ sender: UIButton) {
		router.onComplete(routablePayload())		
	}

	@IBAction func didTapProfileButton(_ sender: UIButton) {
		router.onNext?(routablePayload(data: Route.profile))
	}
}

extension SettingsViewController: Routable {

	enum Route: RoutableData {
		case profile
	}
}
