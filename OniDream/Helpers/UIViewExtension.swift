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
	
	func roundCorners(corners:UIRectCorner, radius: CGFloat = Style.radius) {
		let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
		let mask = CAShapeLayer()
		mask.path = path.cgPath
		self.layer.mask = mask
	}
	
	func setViewBackgroundGradient(sender: UIViewController, _ topColor:UIColor, _ bottomColor:UIColor) {
		
		let gradient = CAGradientLayer()
		let gradientLocations = [0.5, 0.8]
		
		gradient.locations = gradientLocations as [NSNumber]
		gradient.frame = sender.view.bounds
		gradient.colors = [topColor.cgColor, bottomColor.cgColor]
		sender.view.layer.insertSublayer(gradient, at: 0)
	}
    
    func addBackground(imageName: String = "wallpaper", contextMode: UIViewContentMode = .scaleToFill) {
        // setup the UIImageView
        let backgroundImageView = UIImageView(frame: UIScreen.main.bounds)
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.contentMode = contentMode
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(backgroundImageView)
        sendSubview(toBack: backgroundImageView)
        
        // adding NSLayoutConstraints
        let leadingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1.0, constant: 0.0)
        let trailingConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1.0, constant: 0.0)
        let topConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1.0, constant: 0.0)
        let bottomConstraint = NSLayoutConstraint(item: backgroundImageView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1.0, constant: 0.0)
        
        NSLayoutConstraint.activate([leadingConstraint, trailingConstraint, topConstraint, bottomConstraint])
    }
}
