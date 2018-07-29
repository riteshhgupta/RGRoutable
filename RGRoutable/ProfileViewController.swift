//
//  ProfileViewController.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 16/05/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

final class ProfileViewController: UIViewController {

	let router = Router()

	override func viewDidLoad() {
		super.viewDidLoad()
		router.onReturn = {
			print("Coming to ProfileViewController from \(String(describing: $0.sender))")
		}
	}

	@IBAction func didTapBackButton(_ sender: UIButton) {
		router.onComplete(routablePayload())
	}

	@IBAction func didTapSettingsButton(_ sender: UIButton) {
		router.onNext?(routablePayload(data: Route.settings))
	}
}

extension ProfileViewController: Routable {

	enum Route: RoutableData {
		case settings
	}
}
