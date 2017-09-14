//
//  UILabelExtension.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

extension UILabel {
	func addCharactersSpacing(spacing:CGFloat, text:String) {
		let attributedString = NSMutableAttributedString(string: text)
		attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSMakeRange(0, text.characters.count))
		self.attributedText = attributedString
	}
}
