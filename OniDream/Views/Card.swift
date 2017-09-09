//
//  Card.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import PinLayout

class Card: UIView {
	// MARK: The header of the card (with a title and a second label)
	let header: CardHeader
	// MARK: The main part of the card (it's the superview of the content)
	let main: UIView
	// MARK: The content that's a subview of the main
	let content: UIView
	
	init(header: CardHeader, content: UIView) {
		self.header = header
		self.content = content
		self.main = UIView()
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
		
		self.main = UIView()
		self.content = content
		super.init(frame: CGRect.zero)
	}
	
    override func draw(_ rect: CGRect) {
		// MARK: Building the layout
		self.buildLayout()
		// MARK: Styling the card
		self.styleCard()
		// MARK: Styling the content
		self.styleContent()
		// MARK: Style the main
		self.styleMain()
	}
	
	override func layoutSubviews() {
		// MARK: It seems to be the only way to change bgColor
		self.backgroundColor = Color.white50
		
		super.layoutSubviews()
	}
	
	private func buildLayout() {
		// MARK: Nesting the views
		self.addSubview(header)
		self.addSubview(main)
		self.main.addSubview(content)
		
		// MARK: Positionning the views
		header.pin.left().right().height(50)
		main.pin.below(of: header).left().bottom().right()
		content.pin.left().bottom().right().top().margin(Style.margin)
	}
	
	private func styleCard() {
		self.layer.cornerRadius = Style.radius
		self.layer.masksToBounds = true
	}
	
	private func styleMain() {
	}
	
	private func styleContent() {
		content.backgroundColor = Color.clear
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
	}
	
	override func draw(_ rect: CGRect) {
		// Layout
		self.addSubview(self.titleView)
		if (self.hasRightInfo) {
			self.addSubview(self.rightInfoView)
			self.rightInfoView.pin.top().bottom().right().width(100).marginRight(Style.margin)
			self.titleView.pin.left(of: self.rightInfoView, aligned: .top).bottom().left().marginRight(Style.margin).marginLeft(Style.margin)
		} else {
			self.titleView.pin.left().bottom().right().top().margin(Style.margin)
		}
		
		// Styling subviews
		self.styleTitleView()
		if (self.hasRightInfo) {
			self.styleRightInfoView()
		}
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
