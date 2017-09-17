//
//  SleepTimeLineChartView.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepTimeLineChartView: LineChartView {
    var sleepTimes: [Double] = []
    var lastWeekSleepTimes: [Double] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.animate(xAxisDuration: 0, yAxisDuration: 0.5, easingOption: .easeInQuad)
        
        let sleepDesc: Description = Description()
        sleepDesc.textColor = Color.white50
        
        sleepDesc.text = ""
        
        self.chartDescription = sleepDesc
        
        self.rightAxis.labelTextColor = Color.white50
        self.leftAxis.labelTextColor = Color.white50
        self.xAxis.labelTextColor = Color.white50
        
        self.xAxis.labelCount = 7
        self.xAxis.granularity = 1
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.xAxis.drawGridLinesEnabled = false
        
        self.legend.textColor = Color.blue
        
        self.disableZoomEffects()
    }
    
    func drawChart() {
        self.data = getLineChartTimesData()
    }
    
    func disableZoomEffects() {
        self.dragEnabled = false
        self.pinchZoomEnabled = false
        self.doubleTapToZoomEnabled = false
        self.scaleXEnabled = false
        self.scaleYEnabled = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getLineChartTimesData() -> LineChartData {
        var entriesThisWeek: [ChartDataEntry] = []
        var entriesLastWeek: [ChartDataEntry] = []
        
        entriesThisWeek.append(ChartDataEntry(x: 0, y: self.sleepTimes[0]))
        entriesThisWeek.append(ChartDataEntry(x: 1, y: self.sleepTimes[1]))
        entriesThisWeek.append(ChartDataEntry(x: 2, y: self.sleepTimes[2]))
        entriesThisWeek.append(ChartDataEntry(x: 3, y: self.sleepTimes[3]))
        entriesThisWeek.append(ChartDataEntry(x: 4, y: self.sleepTimes[4]))
        entriesThisWeek.append(ChartDataEntry(x: 5, y: self.sleepTimes[5]))
        entriesThisWeek.append(ChartDataEntry(x: 6, y: self.sleepTimes[6]))
        
        entriesLastWeek.append(ChartDataEntry(x: 0, y: self.lastWeekSleepTimes[0]))
        entriesLastWeek.append(ChartDataEntry(x: 1, y: self.lastWeekSleepTimes[1]))
        entriesLastWeek.append(ChartDataEntry(x: 2, y: self.lastWeekSleepTimes[2]))
        entriesLastWeek.append(ChartDataEntry(x: 3, y: self.lastWeekSleepTimes[3]))
        entriesLastWeek.append(ChartDataEntry(x: 4, y: self.lastWeekSleepTimes[4]))
        entriesLastWeek.append(ChartDataEntry(x: 5, y: self.lastWeekSleepTimes[5]))
        entriesLastWeek.append(ChartDataEntry(x: 6, y: self.lastWeekSleepTimes[6]))
        
        
        var chartDataSets : [LineChartDataSet] = []
        
        let entriesThisWeekDataSet = LineChartDataSet(values: entriesThisWeek, label: ChartsText.sleepTimeTW)
        
        entriesThisWeekDataSet.valueTextColor = Color.blue
        entriesThisWeekDataSet.setColors(Color.blue)
        entriesThisWeekDataSet.lineWidth = 2
        entriesThisWeekDataSet.drawFilledEnabled = true
        entriesThisWeekDataSet.fillColor = Color.blue
        entriesThisWeekDataSet.circleRadius = 3
        entriesThisWeekDataSet.axisDependency = YAxis.AxisDependency.left
        entriesThisWeekDataSet.circleColors = [Color.blue]
        
        let entriesLastWeekDataSet = LineChartDataSet(values: entriesLastWeek, label: ChartsText.sleepTimeLW)
        
        entriesLastWeekDataSet.valueTextColor = Color.blue
        entriesLastWeekDataSet.setColors(Color.purple)
        entriesLastWeekDataSet.lineWidth = 2
        entriesLastWeekDataSet.drawFilledEnabled = true
        entriesLastWeekDataSet.circleRadius = 3
        entriesLastWeekDataSet.axisDependency = YAxis.AxisDependency.left
        entriesLastWeekDataSet.fillColor = Color.purple
        entriesLastWeekDataSet.circleColors = [Color.purple]
        
        chartDataSets.append(entriesThisWeekDataSet)
        chartDataSets.append(entriesLastWeekDataSet)
        
        let data = LineChartData(dataSets: chartDataSets)
        
        return data
    }
}
