//
//  DreamForm.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-17.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit

class DreamForm: UIView {
	var container: UIView = UIView()
	var input: Input?
	var textView: TextView
	
	init(input: Input, textView: TextView) {
		self.input = input
		self.textView = textView
		super.init(frame: CGRect.zero)
		self.addSubviews()
	}
	
	override func updateConstraints() {
		self.container.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self).offset(Style.margin)
			make.right.equalTo(self).offset(-Style.margin)
			make.top.equalTo(self)
			make.bottom.equalTo(self)
		}
		
		self.input?.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.container)
			make.right.equalTo(self.container)
			make.height.equalTo(Style.inputHeight)
			make.top.equalTo(self.container).offset(Style.margin)
		}
		
		self.textView.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.container)
			make.right.equalTo(self.container)
			make.top.equalTo((self.input?.snp.bottom)!)
			make.bottom.equalTo(self.container)
		}
		
		super.updateConstraints()
	}
	
	
	private func addSubviews() {
		self.addSubview(container)
		
		self.container.addSubview(self.input!)
		self.container.addSubview(self.textView)
	}
	
	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}
