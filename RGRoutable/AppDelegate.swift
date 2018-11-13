//
//  AppDelegate.swift
//  RGRoutable
//
//  Created by Ritesh Gupta on 25/11/17.
//  Copyright © 2017 Ritesh Gupta. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	let router = AppRouter()
	let window = UIWindow(frame: UIScreen.main.bounds)

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
		window.makeKeyAndVisible()
		window.rootViewController = router.rootViewController
		return true
	}
}

