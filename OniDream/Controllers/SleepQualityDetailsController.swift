//
//  SleepQualityDetailsController.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepQualityDetailsController: UIViewController {
    
    var scrollView: UIScrollView!
    var blurEffectView: UIVisualEffectView!
    var sleepQualityLineChartView : SleepQualityLineChartView!
    var thisWeekTitle : UILabel!
    var lastWeekTitle : UILabel!
    var thisWeekValue : UILabel!
    var lastWeekValue : UILabel!
    var sleepQualityThisWeek: [[String:Double]] = [[:]]
    var sleepQualityLastWeek: [[String:Double]] = [[:]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = ChartsText.sleepQualityDetailsTitle
        
        self.initSleepQualityChart()
        self.initThisWeekValues()
        self.initLastWeekValues()
        
        self.view.addSubview(View(frame: self.view.frame))
        self.edgesForExtendedLayout = []
        
        self.buildLayout()
        // Do any additional setup after loading the view.
    }
    
    private func calcDaySleepQualityFromSleepStates(array: [String:Double]) -> Double {
        if (array.count == 0) {
            return 0.0
        }
        return Double((array["REM"]! + array["DS"]! + array["LD"]!))
    }
    
    private func calcWeekSleepQualityFromSleepStates(array: [[String:Double]]) -> [Double] {
        var sleepQuality : [Double] = [Double](repeating: 0, count: 7)
        var i : Int = 0
        if (array[0].count == 0) {
            return [0.0]
        }
        for item in array {
            sleepQuality[i] = Double(item["REM"]!) + Double(item["DS"]!) + Double(item["LD"]!)
            i = i + 1
        }
        
        return sleepQuality
    }
    
    private func getAverageSleepQualityFromArray(array: [[String:Double]]) -> Double {
        var avgSleepQuality : Double = 0
        
        for item in array {
            let sleepQuality = self.calcDaySleepQualityFromSleepStates(array: item)
            
            avgSleepQuality = avgSleepQuality + sleepQuality
        }
        
        return Double(round(100 * (avgSleepQuality / Double(array.count)) / 100))
    }
    
    func initThisWeekValues() {
        self.thisWeekTitle = UILabel(frame: CGRect(x: 20, y: self.sleepQualityLineChartView.frame.height, width: view.bounds.width - 40, height: 50))
        self.thisWeekTitle.backgroundColor = Color.purple
        self.thisWeekTitle.textColor = Color.white80
        self.thisWeekTitle.text = ChartsText.avgSleepQualityTW
        self.thisWeekTitle.textAlignment = NSTextAlignment.center
        
        self.thisWeekValue = UILabel(frame: CGRect(x: 20, y: self.sleepQualityLineChartView.frame.height + self.thisWeekTitle.frame.height, width: view.bounds.width - 40, height: 50))
        self.thisWeekValue.backgroundColor = Color.white30
        self.thisWeekValue.textColor = Color.white80
        self.thisWeekValue.text = "\(getAverageSleepQualityFromArray(array: self.sleepQualityThisWeek))%"
        self.thisWeekValue.textAlignment = NSTextAlignment.center
    }
    
    func initLastWeekValues() {
        self.lastWeekTitle = UILabel(frame: CGRect(x: 20, y: self.sleepQualityLineChartView.frame.height + self.thisWeekTitle.frame.height + self.thisWeekValue.frame.height + 10, width: view.bounds.width - 40, height: 50))
        self.lastWeekTitle.backgroundColor = Color.purple
        self.lastWeekTitle.textColor = Color.white80
        self.lastWeekTitle.text = ChartsText.avgSleepQualityLW
        self.lastWeekTitle.textAlignment = NSTextAlignment.center
        
        self.lastWeekValue = UILabel(frame: CGRect(x: 20, y: self.sleepQualityLineChartView.frame.height + self.thisWeekTitle.frame.height + thisWeekValue.frame.height + lastWeekTitle.frame.height + 10, width: view.bounds.width - 40, height: 50))
        self.lastWeekValue.backgroundColor = Color.white30
        self.lastWeekValue.textColor = Color.white80
        self.lastWeekValue.text = "\(getAverageSleepQualityFromArray(array: self.sleepQualityLastWeek))%"
        self.lastWeekValue.textAlignment = NSTextAlignment.center
    }
    
    func buildLayout() {
        // Creating the Scroll View
        self.scrollView = UIScrollView(frame: self.view.bounds)
        
        self.scrollView.contentSize = CGSize(width: view.bounds.width, height: self.sleepQualityLineChartView.bounds.height + self.thisWeekValue.frame.height + self.thisWeekTitle.frame.height + self.lastWeekValue.frame.height + self.lastWeekTitle.frame.height + 30)
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        
        self.scrollView.addSubview(self.sleepQualityLineChartView)
        self.scrollView.addSubview(self.thisWeekTitle)
        self.scrollView.addSubview(self.thisWeekValue)
        self.scrollView.addSubview(self.lastWeekTitle)
        self.scrollView.addSubview(self.lastWeekValue)
        
        self.view.addSubview(self.scrollView)
    }
    
    
    func goToPreviousPage(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /* Just init the LineChartView */
    func initSleepQualityChart() {
        self.sleepQualityLineChartView = SleepQualityLineChartView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 360))
        self.sleepQualityLineChartView.sleepQualityThisWeek = self.calcWeekSleepQualityFromSleepStates(array: self.sleepQualityThisWeek)
        self.sleepQualityLineChartView.drawChart()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
