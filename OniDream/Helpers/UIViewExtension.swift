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
	
}
