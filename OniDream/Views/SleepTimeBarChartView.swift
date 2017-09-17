//
//  SleepTimeBarChartView.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepTimeBarChartView: BarChartView {
    var sleepDurations: [Double] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.chartDescription = Description()
        self.chartDescription?.text = ""
        self.xAxis.labelCount = 7
        self.xAxis.granularity = 1
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.drawAxisLineEnabled = false
        self.legend.enabled = false
        self.legend.textColor = Color.white50
        self.disableZoomEffects()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawChart() {
        self.data = getSleepDurationData()
        self.invalidateIntrinsicContentSize()
        
    }
    
    func disableZoomEffects() {
        self.dragEnabled = false
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        self.scaleXEnabled = false
        self.scaleYEnabled = false
    }
    
    func getSleepDurationData() -> BarChartData {
        var entries: [ChartDataEntry] = []
        var i: Int = 0
        
        for sleepDuration in self.sleepDurations {
            entries.append(BarChartDataEntry(x: Double(i), y: sleepDuration))
            i = i + 1
        }
        
        var chartDataSets : [BarChartDataSet] = []
        
        
        let set: BarChartDataSet = BarChartDataSet(values: entries, label: "")
        
        set.valueTextColor = UIColor.white
        set.valueColors = [Color.blue, Color.purple, Color.blue, Color.tealBlue]
        
        chartDataSets.append(set);
        
        let barChartColors: [NSUIColor] = [Color.blue, Color.purple, Color.blue, Color.tealBlue]
        
        set.colors = barChartColors
        
        let data: BarChartData = BarChartData(dataSets: chartDataSets)
        
        return data;
    }
    
}

