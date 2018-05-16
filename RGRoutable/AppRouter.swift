//
//  AppRouter.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 16/05/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

final class AppRouter {

	var rootViewController: UIViewController {
		return UINavigationController(rootViewController: homeVC)
	}

	var homeVC: HomeViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
		controller.router.onNext = { [weak self] payload in
			guard let this = self, let route = payload.data as? HomeViewController.Route else { return }
			switch route {
			case .settings: payload.sender?.present(next: this.settingsVC)
			case .profile: payload.sender?.push(next: this.profileVC)
			}
		}
		return controller
	}

	var settingsVC: SettingsViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
		controller.router.onComplete = { payload in
			payload.sender?.remove(payload: payload)
		}
		return controller
	}

	var profileVC: ProfileViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
		return controller
	}
}
