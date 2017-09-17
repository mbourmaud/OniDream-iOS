//
//  AppDelegate.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
	var window: UIWindow?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		FirebaseApp.configure()

		self.isAppAlreadyLaunchedOnce()
		self.setNavigationBarAppearance(app: application)
		self.setTabBarAppearance()
		return true
	}
	
	// Checking if it's the 1st launch
	func isAppAlreadyLaunchedOnce() {
		let defaults = UserDefaults.standard
		let settings = Settings()
		let realm = try! Realm()
	
		if defaults.string(forKey: "isAppAlreadyLaunchedOnce") != nil {
			print("App already launched")
		} else {
			defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
			
			try! realm.write {
				realm.add(settings)
			}
	
			print("App launched first time")
		}
	}
	
	/* Navigation TabBar style */
	func setTabBarAppearance() {
		UITabBar.appearance().tintColor = Color.white
		UITabBar.appearance().unselectedItemTintColor = Color.white
		UITabBar.appearance().backgroundColor = Color.white30.alpha(0.05)
		UITabBar.appearance().shadowImage = UIImage()
		UITabBar.appearance().backgroundImage = UIImage()
		UITabBar.appearance().barTintColor = Color.white
	}
	
	/* Navigation Bar style */
	func setNavigationBarAppearance(app: UIApplication) {
        
        UIApplication.shared.statusBarView?.backgroundColor = Color.white30.alpha(0.05)
        
		UIApplication.shared.statusBarStyle = .lightContent
		UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
		UINavigationBar.appearance().shadowImage = UIImage()
		UINavigationBar.appearance().isTranslucent = true
		UINavigationBar.appearance().barTintColor = Color.white
        UINavigationBar.appearance().tintColor = Color.white
		UINavigationBar.appearance().backgroundColor = Color.white30.alpha(0.05)
		UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: Color.white,
		                                                    NSFontAttributeName: Style.navigationFont]
	}

	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}

	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
	}

	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}

	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
	}

	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
	}


}

