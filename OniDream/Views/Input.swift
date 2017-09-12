//
//  Input.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class Input: UIView {

	// MARK: The header of the card (with a title and a second label)
	let label: UILabel
	let textField: TextField
	var isSecure: Bool = false
	var placeholder: String = ""
	
	init(label: String, placeholder: String = "", isSecure: Bool = false) {
		self.label = UILabel()
		self.textField = TextField()
		self.label.text = label.uppercased()
		self.isSecure = isSecure
		self.placeholder = placeholder
		
		super.init(frame: CGRect.zero)
		
		self.addSubviews()
		self.styleLabel()
		self.styleTextField()
	}
	
	private func styleLabel() {
		self.label.textColor = Color.white
		self.label.font = Style.titleFont
	}
	
	private func styleTextField() {
		self.textField.backgroundColor = Color.white30
		self.textField.layer.cornerRadius = Style.radius
		self.textField.font = Style.textFont
		self.textField.attributedPlaceholder = NSAttributedString(string: self.placeholder, attributes: [NSFontAttributeName: Style.placeholderFont])
		self.textField.isSecureTextEntry = self.isSecure
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		self.addSubview(self.label)
		self.addSubview(self.textField)
	}
	
	override func updateConstraints() {
		
		self.label.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(30)
			make.top.equalTo(self)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
		
		self.textField.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(50)
			make.top.equalTo(self.label.snp.bottom)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
		
		super.updateConstraints()
	}
	


}
