//
//  UITableViewExtension.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-11.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
	func setTableViewBackgroundGradient(sender: UITableViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
		let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
		let gradientLocations = [0.5, 0.8]
		
		let gradientLayer = CAGradientLayer()
		gradientLayer.colors = gradientBackgroundColors
		gradientLayer.locations = gradientLocations as [NSNumber]
		
		gradientLayer.frame = sender.tableView.bounds
		let backgroundView = UIView(frame: sender.tableView.bounds)
		backgroundView.layer.insertSublayer(gradientLayer, at: 0)
		sender.tableView.backgroundView = backgroundView
	}
}
