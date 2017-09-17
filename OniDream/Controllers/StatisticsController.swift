//
//  StatisticsViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SnapKit
import Charts

class StatisticsController: UIViewController, ChartViewDelegate {
	
	var scrollView: UIScrollView!
    var blurEffectView: UIVisualEffectView!
    var sleepTimeBarChartView : SleepTimeBarChartView!
    var qualityPieChartView: SleepQualityPieChartView!
    
    var sleepTimeThisWeek: [Double] = [7.3, 7.2, 6.7, 7.0, 6.3, 7.5, 6.1]
    var sleepTimeLastWeek: [Double] = [6.2, 7.3, 6.4, 7.2, 5.9, 6.3, 6.1]
    var sleepQualityThisWeek: [[String: Double]] = [
        ["REM" : 18, "LS": 42, "DS": 28, "LD": 12],
        ["REM" : 12, "LS": 42, "DS": 36, "LD": 10],
        ["REM" : 19, "LS": 32, "DS": 27, "LD": 22],
        ["REM" : 17, "LS": 36, "DS": 30, "LD": 17],
        ["REM" : 22, "LS": 28, "DS": 42, "LD": 8],
        ["REM" : 19, "LS": 28, "DS": 32, "LD": 21],
        ["REM" : 17, "LS": 43, "DS": 26, "LD": 14],
        ]
    var sleepQualityLastWeek: [[String: Double]] = [
        ["REM" : 17, "LS": 37, "DS": 36, "LD": 10],
        ["REM" : 12, "LS": 39, "DS": 23, "LD": 26],
        ["REM" : 10, "LS": 43, "DS": 32, "LD": 15],
        ["REM" : 17, "LS": 43, "DS": 26, "LD": 14],
        ["REM" : 22, "LS": 28, "DS": 42, "LD": 8],
        ["REM" : 12, "LS": 42, "DS": 36, "LD": 10],
        ["REM" : 22, "LS": 28, "DS": 42, "LD": 8],
        ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.initSleepTimeChart()
        self.initQualityPieChart()
        sleepTimeBarChartView.delegate = self
        qualityPieChartView.delegate = self
        
        self.view.addSubview(View(frame: self.view.frame))
        self.edgesForExtendedLayout = []
        
		self.buildLayout()
				
		//self.title = "Statistics"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(false)
        
        self.initSleepTimeChart()
        self.initQualityPieChart()
        
        sleepTimeBarChartView.delegate = self
        qualityPieChartView.delegate = self
    }
    
    /* Just init the BarChartView */
    func initSleepTimeChart() {
        self.sleepTimeBarChartView = SleepTimeBarChartView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 360))
        
        self.sleepTimeBarChartView.sleepTimes = self.sleepTimeThisWeek
        self.sleepTimeBarChartView.drawChart()
    }
    
    /* Just init the PieChartView */
    func initQualityPieChart() {
        self.qualityPieChartView = SleepQualityPieChartView(frame: CGRect(x: 0, y: self.sleepTimeBarChartView.bounds.height + 10, width: view.bounds.width, height: 300))
        
        self.qualityPieChartView.sleepQuality = self.sleepQualityThisWeek[self.sleepQualityThisWeek.count - 1]
        self.qualityPieChartView.drawChart()
    }
    
	private func buildLayout() {
		// Creating the two ChartCards
		let pieCard = Card(title: ChartsText.sleepQualityTitle, content: qualityPieChartView)
		let barCard = Card(title: ChartsText.sleepTimeTitle, content: sleepTimeBarChartView)
		
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
	
    func chartValueSelected(_ chartView: ChartViewBase, entry: ChartDataEntry, highlight: Highlight) {
        if chartView is SleepTimeBarChartView {
            if let navigator = navigationController {
                
                let sleepTimeDetailsC : SleepTimeDetailsController = SleepTimeDetailsController()
                sleepTimeDetailsC.sleepTimeLastWeek = self.sleepTimeLastWeek
                sleepTimeDetailsC.sleepTimeThisWeek = self.sleepTimeThisWeek
                
                navigator.pushViewController(sleepTimeDetailsC, animated: true)
            }
        }
        else if chartView is SleepQualityPieChartView {
            if let navigator = navigationController {

                let sleepQualityDetailsC : SleepQualityDetailsController = SleepQualityDetailsController()
                sleepQualityDetailsC.sleepQualityLastWeek = self.sleepQualityLastWeek
                sleepQualityDetailsC.sleepQualityThisWeek = self.sleepQualityThisWeek

                navigator.pushViewController(sleepQualityDetailsC, animated: true)
            }
        }
        
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
