//
//  TabBarViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SwiftIcons

class TabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

		self.delegate = self
	}
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		
		// Statistics Tab
		let statisticsTab = storyboard!.instantiateViewController(withIdentifier: Identifier.statisticsNavigationController)
		let statisticsImage = #imageLiteral(resourceName: "statistics")
		let statisticsImageSelected = #imageLiteral(resourceName: "statisticsSelected")
		let statisticsTabBarItem = UITabBarItem(title: nil, image: statisticsImage, selectedImage: statisticsImageSelected)
		statisticsTabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
		statisticsTab.tabBarItem = statisticsTabBarItem
		
		// Dream Book Tab
		let dreamBookTab = storyboard!.instantiateViewController(withIdentifier: Identifier.dreamBookNavigationController)
		let dreamBookImage = #imageLiteral(resourceName: "dreamBook")
		let dreamBookImageSelected = #imageLiteral(resourceName: "dreamBookSelected")
		let dreamBookTabBarItem = UITabBarItem(title: nil, image: dreamBookImage, selectedImage: dreamBookImageSelected)
		dreamBookTabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
		dreamBookTab.tabBarItem = dreamBookTabBarItem
		
		// Profile Tab
		let profileTab = storyboard!.instantiateViewController(withIdentifier: Identifier.profileNavigationController)
		let profileImage = #imageLiteral(resourceName: "profile")
		let profileImageSelected = #imageLiteral(resourceName: "profileSelected")
		let profileTabBarItem = UITabBarItem(title: nil, image: profileImage, selectedImage: profileImageSelected)
		profileTabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
		profileTab.tabBarItem = profileTabBarItem
		
		// Settings Tab
		let settingsTab = storyboard!.instantiateViewController(withIdentifier: Identifier.settingsNavigationController)
		let settingsImage = #imageLiteral(resourceName: "settings")
		let settingsImageSelected = #imageLiteral(resourceName: "settingsSelected")
		let settingsTabBarItem = UITabBarItem(title: nil, image: settingsImage, selectedImage: settingsImageSelected)
		settingsTabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
		settingsTab.tabBarItem = settingsTabBarItem
		
		self.viewControllers = [statisticsTab, dreamBookTab, profileTab, settingsTab]
		
		self.tabBar.selectionIndicatorImage = UIImage().createSelectionIndicator(color: UIColor.white, size: CGSize(width: tabBar.frame.width/CGFloat(tabBar.items!.count), height: tabBar.frame.height), lineWidth: 2.0)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
