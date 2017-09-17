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
    var sleepTimes: [Double] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.legend.textColor = Color.white80
        self.chartDescription = Description()
        self.chartDescription?.text = ""
        self.xAxis.labelCount = 7
        self.xAxis.granularity = 1
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.drawAxisLineEnabled = false
        self.rightAxis.labelTextColor = Color.white50
        self.leftAxis.labelTextColor = Color.white50
        self.xAxis.labelTextColor = Color.white50
        self.legend.enabled = false
        self.legend.textColor = Color.white80
        self.disableZoomEffects()
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func drawChart() {
        self.data = getSleepTimeData()
        self.invalidateIntrinsicContentSize()
        
    }
    
    func disableZoomEffects() {
        self.dragEnabled = false
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        self.scaleXEnabled = false
        self.scaleYEnabled = false
    }
    
    func getSleepTimeData() -> BarChartData {
        var entries: [ChartDataEntry] = []
        var i: Int = 0
        
        for sleepTime in self.sleepTimes {
            entries.append(BarChartDataEntry(x: Double(i), y: sleepTime))
            i = i + 1
        }
        
        var chartDataSets : [BarChartDataSet] = []
        
        
        let set: BarChartDataSet = BarChartDataSet(values: entries, label: "")
        
        set.valueTextColor = Color.white80
        set.valueColors = [Color.blue, Color.purple, Color.blue, Color.tealBlue]
        
        chartDataSets.append(set);
        
        let barChartColors: [NSUIColor] = [Color.blue, Color.purple, Color.blue, Color.tealBlue]
        
        set.colors = barChartColors
        
        let data: BarChartData = BarChartData(dataSets: chartDataSets)
        
        return data;
    }
    
}

