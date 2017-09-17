//
//  Constants.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-09.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import Foundation
import Hue
import UIKit

internal struct	APIConfig {
	internal static let url = ""
}

internal struct ChartsText {
    // MARK: StatisticsController and Views
    internal static let sleepTimeTitle = "Sleep time this week"
    internal static let sleepQualityTitle = "Sleep quality this week"
    internal static let noData = "NO DATA"
    internal static let rem = "REM"
    internal static let ds = "Deep Sleep"
    internal static let ls = "Light Sleep"
    internal static let ld = "Lucid Dream"
    
    // MARK: SleepTimeDetailsController and Views
    internal static let sleepTimeDetailsTitle = "Sleep Time"
    internal static let avgSleepTimeTW = "Your average sleep time this week"
    internal static let avgSleepTimeLW = "Your average sleep time last week"
    internal static let sleepTimeTW = "This week sleep time (in hours)"
    internal static let sleepTimeLW = "Last week sleep time (in hours)"
    
    // MARK: SleepQualityDetailsController and Views
    internal static let sleepQualityDetailsTitle = "Sleep Quality"
    internal static let avgSleepQualityTW = "Your average sleep quality this week"
    internal static let avgSleepQualityLW = "Your average sleep quality last week"
    internal static let sleepQualityTW = "Sleep quality this week"
    internal static let goodSleepQuality = "Good Sleep Quality"
    internal static let badSleepQuality = "Bad Sleep Quality"
    
}

internal struct Identifier {
	// MARK: Cells Identifiers
	internal static let dreamTableViewCell = "dreamTableViewCell"
	internal static let peripheralCell = "peripheralCell"
	internal static let bluetoothCell = "bluetoothCell"
	internal static let soundSwitchCell = "soundSwitchCell"
	internal static let vibrationSwitchCell = "vibrationSwitchCell"
	internal static let	timeCell = "timeCell"
	internal static let volumeCell = "volumeCell"
	internal static let soundCell = "soundCell"
	internal static let powerCell = "powerCell"
	internal static let ledCell = "ledCell"
	internal static let colorCell = "colorCell"

	// MARK: Segues Identifiers
	internal static let unwindToDreams = "unwindToDreams"
	internal static let composeDream = "composeDream"
	internal static let editDream = "editDream"
	
	// MARK: ViewControllers Identifiers
	internal static let statisticsNavigationController = "statisticsNavigationController"
	internal static let dreamBookNavigationController = "dreamBookNavigationController"
	internal static let profileNavigationController = "profileNavigationController"
	internal static let settingsNavigationController = "settingsNavigationController"
}

internal struct Color {
	// MARK: Main Colors
	internal static let blue = UIColor(red:0.24, green:0.47, blue:0.75, alpha:1.0)
	internal static let purple = UIColor(red:0.45, green:0.55, blue:0.91, alpha:1.0)
	
	// MARK: Success, Danger, Warning, Info colors
	internal static let green = UIColor(red: 0.1098, green: 0.5294, blue: 0.2275, alpha: 1.0)
	internal static let red = UIColor(red: 0.7294, green: 0.1529, blue: 0.1529, alpha: 1.0)
	internal static let orange = UIColor(colorLiteralRed: 255/255, green: 149/255, blue: 0/255, alpha: 1)
	internal static let tealBlue = UIColor(colorLiteralRed: 90/255, green: 200/255, blue: 250/255, alpha: 1)
	
	// MARK: Transparent Colors
	internal static let clear = UIColor.clear
	internal static let white = UIColor(white: 1, alpha: 1)
	internal static let white80 = white.alpha(0.8)
	internal static let white50 = white.alpha(0.5)
	internal static let white30 = white.alpha(0.3)
	internal static let white10 = white.alpha(0.1)
	
	// MARK: Gradients
	internal static let gradient = [Color.purple, Color.blue].gradient()
	
	// MARK: Text Colors
	internal static let titleColor = UIColor.black.alpha(0.6)
	internal static let textColor = UIColor.black.alpha(0.8)
	internal static let placeholderColor = UIColor.black.alpha(0.6)
}


// MARK: General OniDream Styling
internal struct Style {
	// MARK: Miscs
	internal static let radius: CGFloat = 4
	internal static let margin: CGFloat = 10
    internal static let topOffset: CGFloat = UIScreen.main.bounds.height / 10
	
	// MARK: Font
	internal static let titleFont: UIFont = UIFont.systemFont(ofSize: 19)
    internal static let buttonFont: UIFont = UIFont.boldSystemFont(ofSize: 20)
	internal static let textFont: UIFont = UIFont.systemFont(ofSize: 18)
	internal static let placeholderFont: UIFont = UIFont.italicSystemFont(ofSize: Style.textFont.pointSize)
	internal static let navigationFont: UIFont = UIFont.boldSystemFont(ofSize: 22)
	internal static let charSpacing: CGFloat = 0.3
	
	// MARK: Icon Sizes
	internal static let tabBarIconSize: CGFloat = 40
    internal static let inputHeight: CGFloat = 90
    internal static let buttonHeight: CGFloat = 50
}
