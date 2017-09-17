//
//  Cell.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class Cell: UITableViewCell {
	var title: UILabel = UILabel()
	var rightView: UIView = UIView()
	
	override func awakeFromNib() {
		super.awakeFromNib()
		
		// Switch test
		self.rightView = UISwitch(frame: CGRect.zero)

		// Slider
		//self.rightView = title
		
		self.accessoryView = nil
		
		self.addSubview(title)
		self.addSubview(rightView)
		
		self.rightView.backgroundColor = Color.red.alpha(0.7)
		
		self.backgroundColor = Color.white30
		
		self.rightView.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(self)
			make.bottom.equalTo(self)
			make.right.equalTo(self).offset(-Style.margin)
			make.centerX.equalTo(self)
		}
		
		self.title.snp.makeConstraints { (make) -> Void in
			make.right.equalTo(rightView.snp.left)
			make.top.equalTo(self)
			make.bottom.equalTo(self)
			make.left.equalTo(self).offset(Style.margin)
		}
		
		self.styleTitle()
	}
	
	private func styleTitle() {
		self.title.font = Style.titleFont
		self.title.textColor = Color.white
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
