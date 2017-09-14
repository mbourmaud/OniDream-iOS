//
//  TableView.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-13.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class TableView: UITableView {
    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        self.addBackground()
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurEffectView)
        self.backgroundColor = Color.clear
        
        /* 
         let gradientBackgroundColors = [topColor.cgColor, bottomColor.cgColor]
         let gradientLocations = [0.5, 0.8]
         
         let gradientLayer = CAGradientLayer()
         gradientLayer.colors = gradientBackgroundColors
         gradientLayer.locations = gradientLocations as [NSNumber]
         
         gradientLayer.frame = sender.tableView.bounds
         let backgroundView = UIView(frame: sender.tableView.bounds)
         backgroundView.layer.insertSublayer(gradientLayer, at: 0)
         sender.tableView.backgroundView = backgroundView
         */
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
