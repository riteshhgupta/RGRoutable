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

	@IBAction func didTapDismissButton(_ sender: UIButton) {
		router.onComplete(routablePayload())		
	}
}

extension SettingsViewController: Routable {}
