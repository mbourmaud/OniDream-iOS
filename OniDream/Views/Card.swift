//
//  Card.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SnapKit

class Card: UIView {
	// MARK: The header of the card (with a title and a second label)
	let header: CardHeader
	// MARK: The content that's a subview of the main
	var content: UIView
	
	init(header: CardHeader, content: UIView) {
		self.header = header
		self.content = content
		super.init(frame: CGRect.zero)
	}
	
	init(title: String, rightInfo: String = "", content: UIView) {
		// MARK: Creating the labels for the CardHeader
		let titleLabel: UILabel = UILabel()
		let rightInfoLabel: UILabel = UILabel()
		titleLabel.text = title
		rightInfoLabel.text = rightInfo
		
		// MARK: We use a ternaire to determine if we have a rightInfo or not
		self.header = CardHeader(
			titleView: titleLabel,
			hasRightInfo: rightInfo == "" ? false: true ,
			rightInfoView: rightInfoLabel
		)
		
		self.content = content
		super.init(frame: CGRect.zero)
		
		self.backgroundColor = Color.white30
		self.addSubviews()
	}
	
	override func updateConstraints() {
		
		self.header.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(50)
			make.top.equalTo(self)
			make.left.equalTo(self)
			make.right.equalTo(self)
		}
		
		self.content.snp.makeConstraints { (make) -> Void in
			make.bottom.equalTo(self).offset(-Style.margin)
			make.top.equalTo(header.snp.bottom).offset(Style.margin)
			make.left.equalTo(self).offset(Style.margin)
			make.right.equalTo(self).offset(-Style.margin)
		}
		
		super.updateConstraints()
	}
	
    override func draw(_ rect: CGRect) {
		// MARK: Styling the card
		self.styleCard()
		// MARK: Styling the content
		self.styleContent()
	}
	
	private func addSubviews() {
		// MARK: Nesting the views
		self.addSubview(header)
		self.addSubview(content)
	}
	
	private func styleCard() {
		self.layer.cornerRadius = Style.radius
		self.layer.masksToBounds = true
	}
	
	private func styleContent() {
		content.backgroundColor = Color.clear

		if let content = self.content as? UILabel {
			content.numberOfLines = 0
			content.sizeToFit()
		}
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

class CardHeader: UIView {
	let hasRightInfo : Bool
	let titleView: UILabel
	let rightInfoView: UILabel
	
	init(titleView: UILabel, hasRightInfo: Bool = false, rightInfoView: UILabel = UILabel()) {
		self.titleView = titleView
		self.hasRightInfo = hasRightInfo
		self.rightInfoView = rightInfoView
		super.init(frame: CGRect())
		
		self.backgroundColor = Color.white50
		// Adding the subviews
		self.addSubviews()
	}
	
	private func addSubviews() {
		// Adding subviews
		self.addSubview(self.titleView)
		if (self.hasRightInfo) {
			self.addSubview(self.rightInfoView)
		}
	}
	
	override func draw(_ rect: CGRect) {
		// Styling subviews
		self.styleTitleView()
		if (self.hasRightInfo) {
			self.styleRightInfoView()
		}
	}
	
	override func updateConstraints() {
		if (self.hasRightInfo) {
			self.rightInfoView.snp.makeConstraints { (make) -> Void in
				make.width.equalTo(100)
				make.top.equalTo(self)
				make.bottom.equalTo(self)
				make.right.equalTo(self).offset(-Style.margin)
			}
		
			self.titleView.snp.makeConstraints { (make) -> Void in
				make.right.equalTo(rightInfoView.snp.left)
				make.top.equalTo(self)
				make.bottom.equalTo(self)
				make.left.equalTo(self).offset(Style.margin)
			}
		} else {
			self.titleView.snp.makeConstraints { (make) -> Void in
				make.right.equalTo(self).offset(Style.margin)
				make.top.equalTo(self)
				make.bottom.equalTo(self)
				make.left.equalTo(self).offset(Style.margin)
			}
		}
		
		super.updateConstraints()
	}
	
	private func styleTitleView() {
		self.titleView.textAlignment = NSTextAlignment.left
		self.titleView.text = self.titleView.text?.uppercased()
		self.titleView.numberOfLines = 1
		self.titleView.font = Style.titleFont
		self.titleView.textColor = Color.titleColor
		self.titleView.addCharactersSpacing(spacing: Style.charSpacing, text: self.titleView.text!)
	}
	
	private func styleRightInfoView() {
		self.rightInfoView.textAlignment = NSTextAlignment.right
		self.rightInfoView.text = self.rightInfoView.text?.uppercased()
		self.rightInfoView.numberOfLines = 1
		self.rightInfoView.font = Style.textFont
		self.rightInfoView.textColor = Color.textColor
		self.rightInfoView.addCharactersSpacing(spacing: Style.charSpacing, text: self.rightInfoView.text!)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
}
