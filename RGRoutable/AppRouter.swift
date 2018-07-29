//
//  AppRouter.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 16/05/18.
//  Copyright © 2018 Ritesh Gupta. All rights reserved.
//

import Foundation
import UIKit

final class AppNavigationController: UINavigationController, Routable {

	let router = Router()
}

final class AppRouter {

	var rootViewController: UIViewController {
		return AppNavigationController(rootViewController: homeVC)
	}

	var homeVC: HomeViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
		controller.router.onNext = { [weak self] payload in
			guard let this = self, let route = payload.data as? HomeViewController.Route else { return }
			switch route {
			case .settings: payload.sender?.present(next: AppNavigationController(rootViewController: this.settingsVC), animated: true, completion: nil)
			case .profile: payload.sender?.push(next: this.profileVC, animated: true)
			}
		}
		return controller
	}

	var settingsVC: SettingsViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
		controller.router.onComplete = { payload in
			payload.sender?.removeNavigationStack(payload: payload, animated: true, completion: nil)
		}
		controller.router.onNext = { [weak self] payload in
			guard let this = self, let route = payload.data as? SettingsViewController.Route else { return }
			switch route {
			case .profile: payload.sender?.push(next: this.profileVC, animated: true)
			}
		}
		return controller
	}

	var profileVC: ProfileViewController {
		let sb = UIStoryboard(name: "Main", bundle: nil)
		let controller = sb.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
		controller.router.onNext = { [weak self] payload in
			guard let this = self, let route = payload.data as? ProfileViewController.Route else { return }
			switch route {
			case .settings: payload.sender?.push(next: this.settingsVC, animated: true)
			}
		}
		return controller
	}
}
