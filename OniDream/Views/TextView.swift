//
//  TextView.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-17.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import UITextView_Placeholder

class TextView: UIView {
	// MARK: The header of the card (with a title and a second label)
	let label: UILabel
	let textView: UITextView
	var placeholder: String = ""
	
	init(label: String, placeholder: String = "") {
		self.label = UILabel()
		self.textView = UITextView()
		self.label.text = label.uppercased()
		self.placeholder = placeholder
		
		super.init(frame: CGRect.zero)
		
		self.addSubviews()
		self.styleLabel()
		self.styleTextView()
	}
	
	private func styleLabel() {
		self.label.textColor = Color.white
		self.label.font = Style.titleFont
	}
	
	private func styleTextView() {
		self.textView.textContainerInset = UIEdgeInsetsMake(Style.margin, Style.margin / 2, Style.margin, Style.margin / 2)
		self.textView.backgroundColor = Color.white50
		self.textView.layer.cornerRadius = Style.radius
		self.textView.font = Style.textFont
		self.textView.attributedPlaceholder = NSAttributedString(string: self.placeholder,
		                                                         attributes: [NSFontAttributeName: Style.placeholderFont,
		                                                                      NSForegroundColorAttributeName: Color.placeholderColor])
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	private func addSubviews() {
		self.addSubview(self.label)
		self.addSubview(self.textView)
	}
	
	override func updateConstraints() {
		
		self.label.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(Style.inputHeight * 4/10)
			make.top.equalTo(self)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
		
		self.textView.snp.makeConstraints { (make) -> Void in
			make.bottom.equalTo(self)
			make.top.equalTo(self.label.snp.bottom)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
		
		super.updateConstraints()
	}
	

}
