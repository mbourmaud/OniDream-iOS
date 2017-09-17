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
        self.thisWeekTitle = UILabel(frame: CGRect.zero)
        self.thisWeekTitle.backgroundColor = Color.purple
        self.thisWeekTitle.textColor = Color.white80
        self.thisWeekTitle.text = ChartsText.avgSleepQualityTW
        self.thisWeekTitle.textAlignment = NSTextAlignment.center
        
        self.thisWeekValue = UILabel(frame: CGRect.zero)
        
        self.thisWeekValue.backgroundColor = Color.white30
        self.thisWeekValue.textColor = Color.white80
        self.thisWeekValue.text = "\(getAverageSleepQualityFromArray(array: self.sleepQualityThisWeek))%"
        self.thisWeekValue.textAlignment = NSTextAlignment.center
    }
    
    func initLastWeekValues() {
        self.lastWeekTitle = UILabel(frame: CGRect.zero)
        self.lastWeekTitle.backgroundColor = Color.purple
        self.lastWeekTitle.textColor = Color.white80
        self.lastWeekTitle.text = ChartsText.avgSleepQualityLW
        self.lastWeekTitle.textAlignment = NSTextAlignment.center
        
        self.lastWeekValue = UILabel(frame: CGRect.zero)
        self.lastWeekValue.backgroundColor = Color.white30
        self.lastWeekValue.textColor = Color.white80
        self.lastWeekValue.text = "\(getAverageSleepQualityFromArray(array: self.sleepQualityLastWeek))%"
        self.lastWeekValue.textAlignment = NSTextAlignment.center
    }
    
    func buildLayout() {
        // Creating the three ChartCards
        let chartCard = Card(title: ChartsText.sleepQualityTitle, content: self.sleepQualityLineChartView)
        let thisWeekCard = Card(title: ChartsText.avgSleepQualityTW, content: self.thisWeekValue)
        let lastWeekCard = Card(title: ChartsText.avgSleepQualityLW, content: self.lastWeekValue)
        
        // Creating the Scroll View
        self.scrollView = UIScrollView(frame: self.view.bounds)
        
        self.scrollView.autoresizingMask = UIViewAutoresizing.flexibleHeight
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(chartCard)
        self.scrollView.addSubview(thisWeekCard)
        self.scrollView.addSubview(lastWeekCard)

        chartCard.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(300)
            make.left.equalTo(self.view).offset(Style.margin)
            make.top.equalTo(self.scrollView).offset(Style.margin)
            make.right.equalTo(self.view).offset(-Style.margin)
        }
        
        thisWeekCard.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.left.equalTo(self.view).offset(Style.margin)
            make.top.equalTo(chartCard.snp.bottom).offset(Style.margin)
            make.right.equalTo(self.view).offset(-Style.margin)
        }
        
        lastWeekCard.snp.makeConstraints { (make) -> Void in
            make.height.equalTo(100)
            make.left.equalTo(self.view).offset(Style.margin)
            make.top.equalTo(thisWeekCard.snp.bottom).offset(Style.margin)
            make.right.equalTo(self.view).offset(-Style.margin)
            make.bottom.equalTo(self.scrollView).offset(-Style.margin)
        }
        
        self.scrollView.contentSize = CGSize(width: chartCard.bounds.size.width + thisWeekCard.bounds.size.width + lastWeekCard.bounds.size.width,
                                             height: chartCard.bounds.size.height + thisWeekCard.bounds.size.height + lastWeekCard.bounds.size.height)
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
