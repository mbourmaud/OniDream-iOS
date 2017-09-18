//
//  DreamTableViewCell.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class DreamCell: UITableViewCell {
	var titleLabel: UILabel = UILabel()
	var dateLabel: UILabel = UILabel()
	var contentLabel: UILabel = UILabel()
	
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		self.selectionStyle = .none
		
		self.contentView.addSubview(titleLabel)
		self.contentView.addSubview(dateLabel)
		self.contentView.addSubview(contentLabel)
		
	}

	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	override func prepareForReuse() {
		super.prepareForReuse()
		
	}

    override func layoutSubviews() {
        super.layoutSubviews()
		
		self.contentLabel.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.contentView).offset(Style.margin)
			make.right.equalTo(self.contentView).offset(-Style.margin)
			make.bottom.equalTo(self.contentView)
			make.height.equalTo(50)
		}
		
		self.dateLabel.snp.makeConstraints { (make) -> Void in
			make.width.equalTo(100)
			make.right.equalTo(self.contentView).offset(-Style.margin)
			make.top.equalTo(self.contentView)
			make.bottom.equalTo(self.contentLabel.snp.top)
		}
		
		self.titleLabel.snp.makeConstraints { (make) -> Void in
			make.left.equalTo(self.contentView).offset(Style.margin)
			make.right.equalTo(self.dateLabel.snp.left).offset(-Style.margin)
			make.bottom.equalTo(self.contentLabel.snp.top)
			make.top.equalTo(self.contentView)
		}
    }
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
	
}
