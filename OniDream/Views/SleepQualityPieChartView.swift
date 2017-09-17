//
//  SleepQualityPieChartView.swift
//  OniDream
//
//  Created by Martin Porrès on 17/09/2017.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import UIKit
import Charts

class SleepQualityPieChartView: PieChartView {
    var sleepQuality : [String:Double] = [:]
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.legend.textColor = Color.white80
        self.chartDescription = Description()
        self.chartDescription?.text = ""
        self.usePercentValuesEnabled = true
        self.entryLabelFont = NSUIFont(name: "Arial", size: 13)
        self.entryLabelColor = Color.white80
        self.spin(duration: 3000, fromAngle: 10, toAngle: 360, easingOption: .easeInCirc)
        self.legend.textColor = Color.white80
        self.holeColor = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func drawChart() {
        self.data = getSleepQualityData()
    }
    
    func getSleepQualityData() -> PieChartData {
        var entries: [ChartDataEntry] = []
        
        if (self.sleepQuality.count == 0) {
            entries.append(PieChartDataEntry(value: 100, label: ChartsText.noData))
            
        }
        else {
            entries.append(PieChartDataEntry(value: self.sleepQuality["REM"]!, label: ChartsText.rem))
            entries.append(PieChartDataEntry(value: self.sleepQuality["DS"]!, label: ChartsText.ds))
            entries.append(PieChartDataEntry(value: self.sleepQuality["LS"]!, label: ChartsText.ls))
            entries.append(PieChartDataEntry(value: self.sleepQuality["LD"]!, label: ChartsText.ld))
        }
        
        var chartDataSets : [PieChartDataSet] = []
        
        let set : PieChartDataSet = PieChartDataSet(values: entries, label: "")
        
        chartDataSets.append(set)
        
        set.valueTextColor = Color.white80
        
        let pieChartColors: [NSUIColor] = [Color.blue, Color.purple, Color.blue, Color.tealBlue]
        
        set.colors = pieChartColors
        
        set.valueFont = NSUIFont(name: "Arial", size: 8)!
        let data : PieChartData = PieChartData(dataSets: chartDataSets)
        
        return data;
    }
    
}
