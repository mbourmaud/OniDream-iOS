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
		let statisticsImage = UIImage.init(icon: .googleMaterialDesign(.pieChartOutlined), size: CGSize(width: Style.tabBarIconSize, height: Style.tabBarIconSize))
		let statisticsImageSelected = UIImage.init(icon: .googleMaterialDesign(.pieChart), size: CGSize(width: Style.tabBarIconSize, height: Style.tabBarIconSize))
		let statisticsTabBarItem = UITabBarItem(title: nil, image: statisticsImage, selectedImage: statisticsImageSelected)
		statisticsTab.tabBarItem = statisticsTabBarItem
		
		// Dream Book Tab
		let dreamBookTab = storyboard!.instantiateViewController(withIdentifier: Identifier.dreamBookNavigationController)
		let dreamBookImage = UIImage.init(icon: .icofont(.bookAlt), size: CGSize(width: Style.tabBarIconSize, height: Style.tabBarIconSize))
		let dreamBookImageSelected = UIImage.init(icon: .icofont(.book), size: CGSize(width: Style.tabBarIconSize, height: Style.tabBarIconSize))
		let dreamBookTabBarItem = UITabBarItem(title: nil, image: dreamBookImage, selectedImage: dreamBookImageSelected)
		dreamBookTab.tabBarItem = dreamBookTabBarItem
		
		self.viewControllers = [statisticsTab, dreamBookTab]
		
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
