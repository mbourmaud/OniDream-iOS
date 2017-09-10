//
//  DreamsTableViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class DreamsTableViewController: UITableViewController {
	let dreams: [Dream] = []
	var selectedDream: Dream = Dream()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		self.drawNavigationBar()
    }
	
	private func drawNavigationBar() {
		/* Title */
		self.navigationController!.title = "Dream Book"
		self.tabBarItem.title = nil
		
		/* Edit Button */
		self.navigationItem.leftBarButtonItem = self.editButtonItem
		
		/* Add Button */
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeDreamTapped))
	}
	
	func composeDreamTapped(_ sender: UIBarButtonItem) {
		print("Compose Dream Tapped")
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
        return self.dreams.count
    }

	// Before it displays the cell, we want to clear the background
	override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
		cell.backgroundColor = Color.clear
	}
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 200
	}


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifier.dreamTableViewCell, for: indexPath) as! DreamTableViewCell

		// MARK: Fetches the appropriate note for the data source layout.
		let dream = dreams[(indexPath as NSIndexPath).row]
		// MARK: We attribute the dream to the cell
		cell.dream = dream
		
        return cell
    }

	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		self.selectedDream = dreams[indexPath.row]
		performSegue(withIdentifier: "showDream", sender: self)
	}

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
