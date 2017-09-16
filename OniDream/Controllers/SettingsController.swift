//
//  SettingsTableViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-13.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SwiftIcons
import RealmSwift
import AVFoundation
import SwiftySound
import IGColorPicker

class SettingsController: UITableViewController, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate {
	var settings: Settings?
	let realm = try! Realm()
	var numberOfRowsForSection: [Int:Int] = [0:1, 1:3, 2:2, 3:1, 4:1]
	
	/* Apple Ringtones */
	let ringtones = getRingtones()
	
	// Values from the picker (temporary until they are saved in settings)
	var datePickerValue: Date?
	var soundPickerValue: String?
	var colorPickerValue: UIColor?
	
	var cellIdentifiers: [Int: String] = [
		0:Identifier.bluetoothCell,
		1:Identifier.soundSwitchCell,
		2:Identifier.vibrationSwitchCell,
		3:Identifier.timeCell,
		4:Identifier.volumeCell,
		5:Identifier.soundCell,
		6:Identifier.powerCell,
		7:Identifier.ledCell,
	]
	
	var cellViews: [UIView] = []
	
	var cellLabels: [String] = [
		"Connect to your OniMask",
		"Sound",
		"Vibration",
		"Time",
		"Volume",
		"Sound",
		"Power",
		"Color"
	]
	var sectionTitle: [Int:String] = [0:"Bluetooth", 1:"Alarm", 2:"Sound", 3:"Vibration", 4:"Led"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.settings = realm.objects(Settings.self).first
		
		print(self.settings?.sound?.isOn)
		
        self.tableView.backgroundView = View(frame: self.tableView.bounds)
        self.tableView.separatorStyle = .none
		//self.tableView.allowsSelection = false

		self.initCellViews()
    }
	
	private func initCellViews() {
		// BLE LABEL
		let bleLabel = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 100))
		bleLabel.setIcon(icon: .fontAwesome(.angleRight), iconSize: 30, color: Color.white, bgColor: Color.clear)
		
		// TIME LABEL
		let timeLabel = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 100))
		timeLabel.setIcon(icon: .googleMaterialDesign(.alarm), iconSize: 30, color: Color.white, bgColor: Color.clear)
		
		// SOUND LABEL
		let soundLabel = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 100))
		soundLabel.setIcon(icon: .googleMaterialDesign(.musicNote), iconSize: 30, color: Color.white, bgColor: Color.clear)
		
		// COLOR LABEL
		let colorLabel = UILabel(frame: CGRect(x:0, y:0, width: 100, height: 100))
		colorLabel.setIcon(icon: .fontAwesome(.circle), iconSize: 30, color: Color.red, bgColor: Color.clear)
		
		// SOUND SWITCH
		let soundSwitch = UISwitch(frame: CGRect.zero)
		soundSwitch.isOn = (self.settings?.sound?.isOn)!
		soundSwitch.addTarget(self, action: #selector(self.soundValueDidChange), for: .valueChanged)
		
		// VIBRATION SWITCH
		let vibrationSwitch = UISwitch(frame: CGRect.zero)
		vibrationSwitch.isOn = (self.settings?.vibration?.isOn)!
		vibrationSwitch.addTarget(self, action: #selector(self.vibrationValueDidChange), for: .valueChanged)

		// VOLUME SLIDER
		let volumeSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
		volumeSlider.setMaximumValueIcon(icon: .fontAwesome(.volumeUp), customSize: CGSize(width: 30, height: 30), textColor: Color.white)
		volumeSlider.setMinimumValueIcon(icon: .fontAwesome(.volumeDown), customSize: CGSize(width: 32, height: 32), textColor: Color.white)
		volumeSlider.tintColor = Color.purple
		volumeSlider.maximumValue = 10
		volumeSlider.minimumValue = 0
		volumeSlider.value = Float((self.settings!.sound?.volume)!)
		volumeSlider.isEnabled = soundSwitch.isOn
		volumeSlider.addTarget(self, action: #selector(self.volumeValueDidChange), for: .valueChanged)

		// POWER SLIDER
		let powerSlider = UISlider(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
		powerSlider.setMinimumValueIcon(icon: .dripicon(.vibrate), customSize: CGSize(width: 25, height: 25), textColor: Color.white80)
		powerSlider.setMaximumValueIcon(icon: .dripicon(.vibrate), customSize: CGSize(width: 32, height: 32), textColor: Color.white)
		powerSlider.tintColor = Color.purple
		powerSlider.maximumValue = 10
		powerSlider.minimumValue = 0
		powerSlider.value = Float((self.settings!.vibration?.power)!)
		powerSlider.isEnabled = vibrationSwitch.isOn
		powerSlider.addTarget(self, action: #selector(self.powerValueDidChange), for: .valueChanged)

		// ADDING THE VIEWS TO THE ARRAY
		self.cellViews.append(bleLabel)
		self.cellViews.append(soundSwitch)
		self.cellViews.append(vibrationSwitch)
		self.cellViews.append(timeLabel)
		self.cellViews.append(volumeSlider)
		self.cellViews.append(soundLabel)
		self.cellViews.append(powerSlider)
		self.cellViews.append(colorLabel)
	}
	
	func volumeValueDidChange(_ sender: UISlider) {
		try! realm.write {
			self.settings?.sound?.volume = Int(sender.value)
		}
	}
	
	func powerValueDidChange(_ sender: UISlider) {
		try! realm.write {
			self.settings?.vibration?.power = Int(sender.value)
		}
	}
	
	func soundValueDidChange(_ sender: UISwitch) {
		try! realm.write {
			self.settings?.sound?.isOn = sender.isOn
		}
		
		if let volumeSlider = self.cellViews[4] as? UISlider {
			volumeSlider.isEnabled = sender.isOn
		}
	}
	
	func vibrationValueDidChange(_ sender: UISwitch) {
		try! realm.write {
			self.settings?.vibration?.isOn = sender.isOn
		}
		
		if let powerSlider = self.cellViews[6] as? UISlider {
			powerSlider.isEnabled = sender.isOn
		}
	}
	
	/* Display the UIDatePickerView into an UIActionSheet */
	func presentTimePickerInActionSheet() {
		self.clearsSelectionOnViewWillAppear = false
		
		/* Declaring the alert controller
		* The \n are used to create some place so we can draw the UIDatePicker
		*/
		let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
		
		/* Setting the DatePickerView */
		let margin:CGFloat = 10.0
		let rect = CGRect(x: margin, y: margin, width: alertController.view.bounds.size.width - margin * 4.0, height: 240)
		let datePickerView = UIDatePicker(frame: rect)
		
		datePickerView.addTarget(self, action: #selector(self.timePickerChanged(sender:)), for: .valueChanged)
		
		
		/* Date Picker attributes
		* We want an interval of 15 minutes, we want the datePicker on time mode, not datetime
		* We also want to use the locale fr_FR so it'll use 24hours format instead of 12
		*/
		datePickerView.date = (self.settings?.alarm?.time)!
		datePickerView.minuteInterval = 15
		datePickerView.datePickerMode = UIDatePickerMode(rawValue: 0)!
		datePickerView.locale = Locale(identifier: "fr_FR")
		
		alertController.view.addSubview(datePickerView)
		
		/* We create two actions - Save and Delete */
		let saveAction = UIAlertAction(title: "Save", style: .default, handler: self.timePickerAlertCallback)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: self.timePickerAlertCallback)
		
		/* Now we add the two actions to the alertController */
		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)
		
		/* We just display the alert */
		DispatchQueue.main.async {
			self.present(alertController, animated: true, completion:{})
		}
	}
	
	func timePickerChanged(sender: UIDatePicker) {
		self.datePickerValue = sender.date
	}
	
	func timePickerAlertCallback(alert: UIAlertAction) {
		if alert.title == "Save" {
			try! realm.write {
				self.settings?.alarm?.time = self.datePickerValue!
			}
			self.setAlarmTimeLabelFromDate(date: (self.settings?.alarm?.time)!)
		}
	}
	
	private func setAlarmTimeLabelFromDate(date: Date) {
		let calendar = Calendar.current
		
		let hour = calendar.component(.hour, from: (self.settings?.alarm?.time)!)
		let minutes = calendar.component(.minute, from: (self.settings?.alarm?.time)!)
		
		if let alarmTimeLabel = self.cellViews[3] as? UILabel {
			if (hour < 10 && minutes < 10) {
				alarmTimeLabel.text = "0\(hour):0\(minutes)"
			}
			else if (hour < 10 && minutes >= 10) {
				alarmTimeLabel.text = "0\(hour):\(minutes)"
			}
				
			else if (hour >= 10 && minutes < 10) {
				alarmTimeLabel.text = "\(hour):0\(minutes)"
			}
			else {
				alarmTimeLabel.text = "\(hour):\(minutes)"
			}
		}
	}
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		let cell = tableView.cellForRow(at: indexPath)
		
		if cell?.reuseIdentifier == Identifier.timeCell {
			presentTimePickerInActionSheet()
		}
		
		if cell?.reuseIdentifier == Identifier.soundCell && (self.settings?.sound?.isOn)! {
			presentSoundListInActionSheet()
		}
		
		/*
		if cell?.reuseIdentifier == "ledViewCell" {
			presentColorPickerInActionSheet()
		}*/
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerLabel = UILabel()
        
        headerLabel.text = self.sectionTitle[section]?.uppercased()
        headerLabel.font = Style.titleFont
        headerLabel.textColor = Color.titleColor
		
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width - 20, height: 40))
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(headerView).offset(Style.margin)
            make.right.equalTo(headerView)
            make.bottom.equalTo(headerView)
            make.top.equalTo(headerView)
        }
        
        headerView.backgroundColor = Color.white50
        
        return headerView
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		let backgroundView = UIView(frame: CGRect.zero)
		backgroundView.backgroundColor = Color.white30
		cell.backgroundColor = Color.clear
		cell.backgroundView = backgroundView
		cell.textLabel!.text = self.cellLabels[cell.tag]
		cell.textLabel!.font = Style.titleFont
		cell.textLabel!.textColor = Color.white
		cell.accessoryView = self.cellViews[cell.tag]
		cell.selectionStyle = .none
	}

	/* Display the UIPicker for the sounds into an UIActionSheet */
	func presentSoundListInActionSheet() {
		self.clearsSelectionOnViewWillAppear = false
		
		/* Declaring the alert controller
		* The \n are used to create some space so we can draw the UIDatePicker
		*/
		let alertController = UIAlertController(title: "\n\n\n\n\n\n\n\n\n\n\n", message: nil, preferredStyle: UIAlertControllerStyle.actionSheet)
		
		/* Setting the DatePickerView */
		let margin:CGFloat = 10.0
		let rect = CGRect(x: margin, y: margin, width: alertController.view.bounds.size.width - margin * 4.0, height: 240)
		let soundListView = UIPickerView(frame: rect)
		
		soundListView.dataSource = self
		soundListView.delegate = self
		
		/* Select the row that matches the current sound title name */
		let val = self.ringtones.index(where: { $0.name == self.settings?.sound?.name })
		soundListView.selectRow(val!, inComponent: 0, animated: true)
		
		alertController.view.addSubview(soundListView)
		
		/* We create two actions - Save and Delete */
		let saveAction = UIAlertAction(title: "Save", style: .default, handler: self.soundListAlertCallback)
		let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: self.soundListAlertCallback)
		
		/* Now we add the two actions to the alertController */
		alertController.addAction(saveAction)
		alertController.addAction(cancelAction)
		
		/* We just display the alert */
		DispatchQueue.main.async {
			self.present(alertController, animated: true, completion:{})
		}
	}
	
	func soundListAlertCallback(alert: UIAlertAction) {
		if alert.title == "Save" {
			SwiftySound.Sound.stopAll()
			try! realm.write {
				self.settings?.sound?.name = self.soundPickerValue!
			}
			//self.soundNameLabel.text = self.settings.sound.title
		}
		
		SwiftySound.Sound.stopAll()
		
	}
	
	/* We only have 1 component in the pickerview */
	func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
		return 1
	}
	
	/* set the number of rows of the pickerView */
	func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
		return self.ringtones.count
	}
	
	/* set the title for each row */
	func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
		return self.ringtones[row].name
	}
	
	/* Here we know which sound has been selected */
	func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
		self.soundPickerValue = self.ringtones[row].name
		SwiftySound.Sound.stopAll()
		SwiftySound.Sound.play(file: self.ringtones[row].url, fileExtension: self.ringtones[row].ext, numberOfLoops: 1)
	}
	
	@available(iOS 2.0, *)
	func numberOfComponents(in pickerView: UIPickerView) -> Int {
		return 1
	}
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return self.numberOfRowsForSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.numberOfRowsForSection[section]!
    }

}
