//
//  SleepTimeDetailsController.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepTimeDetailsController: UIViewController {
    
    var scrollView: UIScrollView!
    var blurEffectView: UIVisualEffectView!
    var sleepTimeLineChartView : SleepTimeLineChartView!
    var thisWeekTitle : UILabel!
    var lastWeekTitle : UILabel!
    var thisWeekValue : UILabel!
    var lastWeekValue : UILabel!
    var sleepTimeThisWeek : [Double] = []
    var sleepTimeLastWeek : [Double] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ChartsText.sleepTimeDetailsTitle
        
        self.initSleepTimeChart()
        self.initThisWeekValues(value: self.calculAverageSleepTimeFromArray(array: self.sleepTimeThisWeek))
        self.initLastWeekValues(value: self.calculAverageSleepTimeFromArray(array: self.sleepTimeLastWeek))
        
        self.view.addSubview(View(frame: self.view.frame))
        self.edgesForExtendedLayout = []
        
        self.buildLayout()
        // Do any additional setup after loading the view.
    }
    
    private func calculAverageSleepTimeFromArray(array: [Double]) -> Double {
        var total : Double = 0
        
        for item in array {
            total = total + item
        }
        return total / 7
    }
    
    private func getFormattedAverageSleepTimeFromHours(hours: Double) -> String {
        let h : Int = Int(hours)
        let minutes : Int = Int((hours - Double(h)) * 60)

        return "\(h) hours and \(minutes) minutes"
    }
    
    func initThisWeekValues(value: Double) {
        self.thisWeekTitle = UILabel(frame: CGRect(x: 20, y: self.sleepTimeLineChartView.frame.height, width: view.bounds.width - 40, height: 50))
        self.thisWeekTitle.backgroundColor = Color.purple
        self.thisWeekTitle.textColor = Color.white80
        self.thisWeekTitle.text = ChartsText.avgSleepTimeTW
        self.thisWeekTitle.textAlignment = NSTextAlignment.center
        
        self.thisWeekValue = UILabel(frame: CGRect(x: 20, y: self.sleepTimeLineChartView.frame.height + self.thisWeekTitle.frame.height, width: view.bounds.width - 40, height: 50))
        self.thisWeekValue.backgroundColor = Color.white30
        self.thisWeekValue.textColor = Color.white80
        self.thisWeekValue.text = self.getFormattedAverageSleepTimeFromHours(hours: value)
        self.thisWeekValue.textAlignment = NSTextAlignment.center
    }
    
    func initLastWeekValues(value: Double) {
        self.lastWeekTitle = UILabel(frame: CGRect(x: 20, y: self.sleepTimeLineChartView.frame.height + self.thisWeekTitle.frame.height + self.thisWeekValue.frame.height + 10, width: view.bounds.width - 40, height: 50))
        self.lastWeekTitle.backgroundColor = Color.purple
        self.lastWeekTitle.textColor = Color.white80
        self.lastWeekTitle.text = ChartsText.avgSleepTimeLW
        self.lastWeekTitle.textAlignment = NSTextAlignment.center
        
        self.lastWeekValue = UILabel(frame: CGRect(x: 20, y: self.sleepTimeLineChartView.frame.height + self.thisWeekTitle.frame.height + thisWeekValue.frame.height + lastWeekTitle.frame.height + 10, width: view.bounds.width - 40, height: 50))
        self.lastWeekValue.backgroundColor = Color.white30
        self.lastWeekValue.textColor = Color.white80
        self.lastWeekValue.text = self.getFormattedAverageSleepTimeFromHours(hours: value)
        self.lastWeekValue.textAlignment = NSTextAlignment.center
    }
    
    
    
    func buildLayout() {
        // Creating the Scroll View
        self.scrollView = UIScrollView(frame: self.view.bounds)
        
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: self.sleepTimeLineChartView.bounds.height + self.thisWeekValue.frame.height + self.thisWeekTitle.frame.height + self.lastWeekValue.frame.height + self.lastWeekTitle.frame.height + 30)
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        self.scrollView.addSubview(self.sleepTimeLineChartView)
        self.scrollView.addSubview(self.thisWeekTitle)
        self.scrollView.addSubview(self.thisWeekValue)
        self.scrollView.addSubview(self.lastWeekTitle)
        self.scrollView.addSubview(self.lastWeekValue)
        
        self.view.addSubview(self.scrollView)
    }
    
    /* Just init the LineChartView */
    func initSleepTimeChart() {
        self.sleepTimeLineChartView = SleepTimeLineChartView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 360))
        self.sleepTimeLineChartView.sleepTimes = self.sleepTimeThisWeek
        self.sleepTimeLineChartView.lastWeekSleepTimes = self.sleepTimeLastWeek
        self.sleepTimeLineChartView.drawChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
