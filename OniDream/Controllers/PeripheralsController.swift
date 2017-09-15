//
//  PeripheralsController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-15.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import SwiftMessages
import CoreBluetooth

class PeripheralsController: UITableViewController, BluetoothSerialDelegate {
	
	var refreshButton: UIBarButtonItem!
	
	func serialDidChangeState() {
		print("Serial did change state")
		var error : Bool = false
		var error_msg : String = ""
		
		if serial.centralManager.state == .poweredOff {
			error_msg = "Please turn bluetooth on"
			error = true
		}
		if serial.centralManager.state == .unsupported {
			error_msg = "Bluetooth is not supported on your device"
			error = true
			
		}
		if serial.centralManager.state == .resetting {
			error_msg = "Something's wrong. Try to restart the Bluetooth"
			error = true
			
		}
		
		if serial.centralManager.state == .unauthorized {
			error_msg = "Bluetooth has not been authorized"
			error = true
			
		}
		
		if serial.centralManager.state == .unknown {
			error_msg = "Something is wrong"
			error = true
			
		}
		
		if serial.centralManager.state == .poweredOn {
			print("OK COOL")
			serial.startScan()
			Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(PeripheralsController.scanTimeOut), userInfo: nil, repeats: false)
		}
		
		
		if (error) {
			ModalController.shared.showModal(title: "Bluetooth", message: error_msg, type: .error)
		}
		
	}
	
	func serialDidDisconnect(_ peripheral: CBPeripheral, error: NSError?) {
		print("Serial did disconnect")
	}
	
	var dataFromPeripheral : String = ""
	
	/// The peripherals that have been discovered (no duplicates and sorted by asc RSSI)
	var peripherals: [(peripheral: CBPeripheral, RSSI: Float)] = []
	
	/// The peripheral the user has selected
	var selectedPeripheral: CBPeripheral?
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.backgroundView = View(frame: self.tableView.bounds)
		self.tableView.separatorStyle = .none
        self.clearsSelectionOnViewWillAppear = true
		self.refreshButton = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(self.refreshPeripherals))
		self.navigationItem.rightBarButtonItem = self.refreshButton
		
		serial = BluetoothSerial(delegate: self)
    }
	
	func serialDidDiscoverPeripheral(_ peripheral: CBPeripheral, RSSI: NSNumber?) {
		
		print("PERIPHERAL FOUND")
		
		// check whether it is a duplicate
		for exisiting in peripherals {
			if exisiting.peripheral.identifier == peripheral.identifier { return }
		}
		
		// add to the array, next sort & reload
		let theRSSI = RSSI?.floatValue ?? 0.0
		peripherals.append(peripheral: peripheral, RSSI: theRSSI)
		peripherals.sort { $0.RSSI < $1.RSSI }
		tableView.reloadData()
	}
	
	func serialDidFailToConnect(_ peripheral: CBPeripheral, error: NSError?) {
		self.refreshButton.isEnabled = true
	}
	
	func refreshPeripherals(_ sender: UIBarButtonItem) {
		self.peripherals = []
		self.tableView.reloadData()
		self.refreshButton.isEnabled = false
		self.title = "Scanning ..."
		
		ModalController.shared.showModal(title: "Scanning", message: "Looking for BLE peripherals", type: .loader, position: .bottom)

		serial.startScan()
		Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(PeripheralsController.scanTimeOut), userInfo: nil, repeats: false)
	}
	
	/// Should be called 10s after we've begun scanning
	func scanTimeOut() {
		// timeout has occurred, stop scanning and give the user the option to try again
		serial.stopScan()
		self.refreshButton.isEnabled = true
		title = "Done scanning"
		SwiftMessages.hideAll()
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.peripherals.count
    }

	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		// return a cell with the peripheral name as text in the label
		let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.peripheralCell)!
		let label = cell.viewWithTag(1) as! UILabel!
		label?.text = peripherals[(indexPath as NSIndexPath).row].peripheral.name
		return cell
	}
	

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
