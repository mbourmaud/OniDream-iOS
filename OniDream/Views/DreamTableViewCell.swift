//
//  DreamTableViewCell.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class DreamTableViewCell: UITableViewCell {
	var dream: Dream = Dream()
	var card: Card!
	var contentLabel: UILabel = UILabel()
	
    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.contentLabel.text = self.dream.content
		self.card = Card(title: self.dream.title, rightInfo: self.dream.date.description, content: self.contentLabel)
		self.card.backgroundColor = Color.white50
		
		self.contentView.addSubview(self.card)
		
		self.card.snp.makeConstraints { (make) -> Void in
			make.edges.equalTo(self.contentView).inset(UIEdgeInsetsMake(Style.margin, Style.margin, Style.margin, Style.margin))
		}
    }
	
	override func draw(_ rect: CGRect) {
		/*for view in self.contentView.subviews {
			view.removeFromSuperview()
		}*/
		
		
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
}
