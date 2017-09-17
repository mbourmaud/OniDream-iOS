//
//  SleepQualityLineChartView.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepQualityLineChartView: LineChartView {
    
    var sleepQualityThisWeek: [Double] = [0, 0, 0, 0, 0, 0, 0]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let upper_limit: ChartLimitLine = ChartLimitLine(limit: 65, label: ChartsText.goodSleepQuality)
        upper_limit.lineWidth = 2
        upper_limit.lineDashLengths = [10, 10, 10]
        upper_limit.labelPosition = ChartLimitLine.LabelPosition.rightTop
        upper_limit.valueTextColor = Color.white50
        
        let bottom_limit: ChartLimitLine = ChartLimitLine(limit: 50, label: ChartsText.badSleepQuality)
        bottom_limit.lineWidth = 2
        bottom_limit.lineDashLengths = [10, 10, 10]
        bottom_limit.labelPosition = ChartLimitLine.LabelPosition.rightTop
        bottom_limit.valueTextColor = Color.white50
        
        let sleepDesc: Description = Description()
        
        sleepDesc.textColor = Color.blue
        self.legend.textColor = Color.blue
        
        
        self.chartDescription = sleepDesc
        
        self.xAxis.labelPosition = XAxis.LabelPosition.bottom
        self.xAxis.drawGridLinesEnabled = false
        self.xAxis.granularity = 1
        self.xAxis.labelCount = 7
        
        self.rightAxis.addLimitLine(upper_limit)
        self.rightAxis.addLimitLine(bottom_limit)
        self.rightAxis.labelTextColor = Color.white50
        self.leftAxis.labelTextColor = Color.white50
        self.xAxis.labelTextColor = Color.white50
        
        self.disableZoomEffects()
    }
    
    func drawChart() {
        self.data = getLineChartQualityData()
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
    
    func getLineChartQualityData() -> LineChartData {
        var valsComp1: [ChartDataEntry] = []
        
        if (sleepQualityThisWeek[0] == 0) {
            valsComp1.append(ChartDataEntry(x: 0, y: 0))
            valsComp1.append(ChartDataEntry(x: 1, y: 0))
            valsComp1.append(ChartDataEntry(x: 2, y: 0))
            valsComp1.append(ChartDataEntry(x: 3, y: 0))
            valsComp1.append(ChartDataEntry(x: 4, y: 0))
            valsComp1.append(ChartDataEntry(x: 5, y: 0))
            valsComp1.append(ChartDataEntry(x: 6, y: 0))
        }
        else {
            valsComp1.append(ChartDataEntry(x: 0, y: sleepQualityThisWeek[0]))
            valsComp1.append(ChartDataEntry(x: 1, y: sleepQualityThisWeek[1]))
            valsComp1.append(ChartDataEntry(x: 2, y: sleepQualityThisWeek[2]))
            valsComp1.append(ChartDataEntry(x: 3, y: sleepQualityThisWeek[3]))
            valsComp1.append(ChartDataEntry(x: 4, y: sleepQualityThisWeek[4]))
            valsComp1.append(ChartDataEntry(x: 5, y: sleepQualityThisWeek[5]))
            valsComp1.append(ChartDataEntry(x: 6, y: sleepQualityThisWeek[6]))
        }
        
        
        let setComp1 = LineChartDataSet(values: valsComp1, label: ChartsText.sleepQualityTW)
        setComp1.setColor(Color.blue)
        setComp1.fillColor = Color.purple
        setComp1.circleColors = [Color.white50]
        setComp1.circleRadius = 3
        setComp1.axisDependency = YAxis.AxisDependency.left
        setComp1.drawFilledEnabled = true
        setComp1.lineWidth = 2
        
        setComp1.valueTextColor = UIColor.darkGray
        
        
        var chartDataSets : [LineChartDataSet] = []
        
        chartDataSets.append(setComp1)
        
        let data = LineChartData(dataSets: chartDataSets)
        
        return data
    }
}
