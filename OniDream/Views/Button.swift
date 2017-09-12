//
//  Button.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-12.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class Button: UIButton {

	// MARK: The header of the card (with a title and a second label)
	let label: String
	let borderColor: UIColor
	let textColor: UIColor
	let backColor: UIColor
	
	
	init(label: String, borderColor: UIColor = Color.white, textColor: UIColor = Color.white, backColor: UIColor = Color.clear) {
		self.label = label
		self.borderColor = borderColor
		self.textColor = textColor
		self.backColor = backColor
		
		super.init(frame: CGRect.zero)
		
		self.styleButton()
	}
	
	private func styleButton() {
		self.setTitle(self.label.uppercased(), for: .normal)
		self.setTitleColor(self.textColor, for: .normal)
		self.titleLabel?.font = Style.titleFont
		self.layer.cornerRadius = Style.radius
		self.layer.borderWidth = 2.0
		self.layer.borderColor = self.borderColor.cgColor
		self.backgroundColor = self.backColor
	}
	
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
