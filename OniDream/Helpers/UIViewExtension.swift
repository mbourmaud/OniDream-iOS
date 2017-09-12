//
//  UIViewExtension.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

extension UIView {
	func addRoundedCorners(byRoundingCorners: UIRectCorner, radius: CGFloat) {
		let rectShape = CAShapeLayer()
		rectShape.bounds = self.frame
		rectShape.position = self.center
		rectShape.path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: byRoundingCorners, cornerRadii: CGSize(width: radius, height: radius)).cgPath
		
		self.layer.mask = rectShape
	}
	
	func setViewBackgroundGradient(sender: UIViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
		
		let gradient = CAGradientLayer()
		let gradientLocations = [0.5, 0.8]
		
		gradient.locations = gradientLocations as [NSNumber]
		gradient.frame = sender.view.bounds
		gradient.colors = [topColor.cgColor, bottomColor.cgColor]
		sender.view.layer.insertSublayer(gradient, at: 0)
	}
}
