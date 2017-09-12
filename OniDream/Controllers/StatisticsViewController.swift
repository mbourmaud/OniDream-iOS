//
//  StatisticsViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SnapKit
import SwiftCharts
import PieCharts

class StatisticsViewController: UIViewController {
	
	var scrollView: UIScrollView!

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.buildLayout()
		
		self.view.setViewBackgroundGradient(sender: self, Color.purple, Color.blue)
		
		//self.title = "Statistics"
    }

	private func buildLayout() {
		// Creating the two ChartCards
		let pieCard = Card(title: "PIE", content: UIView())
		let barCard = Card(title: "BAR", content: UIView())
		
		// Creating the Scroll View
		self.scrollView = UIScrollView(frame: self.view.bounds)
		self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
		self.view.addSubview(scrollView)
		self.scrollView.addSubview(barCard)
		self.scrollView.addSubview(pieCard)
	
		barCard.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(300)
			make.left.equalTo(self.view).offset(Style.margin)
			make.top.equalTo(self.scrollView).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
		}
		
		
		pieCard.snp.makeConstraints { (make) -> Void in
			make.height.equalTo(300)
			make.left.equalTo(self.view).offset(Style.margin)
			make.top.equalTo(barCard.snp.bottom).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
			make.bottom.equalTo(self.scrollView).offset(-Style.margin)
		}
		
		self.scrollView.contentSize = CGSize(width: barCard.bounds.size.width + pieCard.bounds.size.width,
		                                     height: barCard.bounds.size.height + pieCard.bounds.size.height)

		
	
	}
	
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
