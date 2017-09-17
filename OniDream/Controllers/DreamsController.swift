//
//  DreamsTableViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class DreamsController: UITableViewController {
	var dreams: [Dream] = []
	var selectedDream: Dream = Dream()
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
        self.tableView.backgroundView = View(frame: self.tableView.bounds)
		self.tableView.separatorStyle = .none
        
        self.tableView.scrollIndicatorInsets = UIEdgeInsetsMake(64, 0, 0, 0)
        
		self.drawNavigationBar()
    }
    
    override func viewDidLayoutSubviews() {
        if let rect = self.navigationController?.navigationBar.frame {
            let y = rect.size.height + rect.origin.y
            self.tableView.contentInset = UIEdgeInsetsMake( y, 0, 0, 0)
        }
    }
	
	private func drawNavigationBar() {		
		/* Add Button */
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeDreamTapped))
	}
	
	func composeDreamTapped(_ sender: UIBarButtonItem) {
		print("COMPOSE DREAM TAPPED")
		self.selectedDream = Dream()
		self.performSegue(withIdentifier: Identifier.composeDream, sender: self)
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
		print("DID SELECT ROW")
		print(self.selectedDream.description)
	}

	
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.dreams.remove(at: (indexPath as NSIndexPath).row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			
			/* We save the modifications into the local storage */
			//self.dreamsService.dreams = self.dreams
			//self.dreamsService.saveDreams()
		}
    }
	
	@IBAction func unwindToDreams(_ sender: UIStoryboardSegue) {
		/* If the sender is DreamVC, we get the dream and add it to the tableView */
		if let sourceViewController = sender.source as? DreamController {
			let dream : Dream = sourceViewController.dream
			
			/* If the dream has just been upadted, we modify it and reload the rows */
			if let selectedIndexPath = tableView.indexPathForSelectedRow {
				dreams[(selectedIndexPath as NSIndexPath).row] = dream
				tableView.reloadRows(at: [selectedIndexPath], with: .none)
			}
			/* If the dream is a new one, we just insert it to the rows */
			else {
				let newIndexPath = IndexPath(row: dreams.count, section: 0)
				dreams.append(dream)
				tableView.insertRows(at: [newIndexPath], with: .bottom)
			}
			
			/* We save the modifications into the local storage */
			//self.dreamsService.dreams = dreams
			//self.dreamsService.saveDreams()
		}
	}

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dreamViewController = segue.destination as? DreamController {
			print("PREPARE TO SEGUE")
			dreamViewController.dream = Dream(title: "", content: "", date: Date())
			print(selectedDream.description)
		}
    }

}
