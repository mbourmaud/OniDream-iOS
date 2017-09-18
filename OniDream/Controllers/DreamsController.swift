//
//  DreamsTableViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-10.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit
import RealmSwift

class DreamsController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	var dreams: List<Dream> = List<Dream>()
	var selectedDream: Dream = Dream()
	var tableView: UITableView!
	
	override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView = UITableView()
		
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowo"))
		self.dreams.append(Dream(title: "OUIIIIIII", content: "wowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowowowoowowoowowo"))

		print(self.dreams.count)
		
        self.view = View(frame: self.view.frame)
		
		self.view.addSubview(self.tableView)
		
		self.tableView.snp.makeConstraints { (make) -> Void in
			make.top.equalTo(self.view).offset((self.navigationController?.navigationBar.frame.size.height)! + UIApplication.shared.statusBarFrame.height)
			make.bottom.equalTo(self.view).offset(-(self.tabBarController?.tabBar.frame.size.height)!)
			make.left.equalTo(self.view).offset(Style.margin)
			make.right.equalTo(self.view).offset(-Style.margin)
		}
		
		self.tableView.backgroundColor = Color.clear
		self.tableView.backgroundView?.backgroundColor = Color.clear
		self.tableView.separatorStyle = .none
		self.tableView.showsHorizontalScrollIndicator = false
		self.tableView.showsVerticalScrollIndicator = false
		
		// These tasks can also be done in IB if you prefer.
		self.tableView.register(DreamCell.self, forCellReuseIdentifier: Identifier.dreamTableViewCell)
		self.tableView.delegate = self
		self.tableView.dataSource = self
	
		self.drawNavigationBar()
    }
	
	private func drawNavigationBar() {		
		/* Add Button */
		self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(composeDreamTapped))
	}
	
	// Segue to DreamForm
	func composeDreamTapped(_ sender: UIBarButtonItem) {
		self.selectedDream = Dream()
		self.performSegue(withIdentifier: Identifier.composeDream, sender: self)
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.dreams.count
    }
	
	// There is just one row in every section
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 1
	}
	
	// Set the spacing between sections
	func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
		return Style.margin
	}
	
	// Make the background color show through
	func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
		let headerView = UIView()
		headerView.backgroundColor = Color.clear
		return headerView
	}

	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		return 100
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = self.tableView.dequeueReusableCell(withIdentifier: Identifier.dreamTableViewCell) as! DreamCell
		
		let dream = self.dreams[indexPath.section]
		
		// note that indexPath.section is used rather than indexPath.row
		cell.titleLabel.text = dream.title
		cell.titleLabel.textColor = Color.white
		cell.titleLabel.font = Style.buttonFont
		
		cell.contentLabel.text = dream.content
		cell.contentLabel.textColor = Color.white80
		
		cell.dateLabel.textColor = Color.white80
		cell.dateLabel.font = Style.placeholderFont
		cell.dateLabel.textAlignment = NSTextAlignment.right
		cell.dateLabel.text = "\(dream.date.daysAgo) days ago"
		
		// add border and color
		cell.backgroundColor = Color.white10
		cell.layer.cornerRadius = Style.radius
		cell.clipsToBounds = true
		
		return cell
	}
	
	// method to run when table view cell is tapped
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// note that indexPath.section is used rather than indexPath.row
		self.selectedDream = dreams[indexPath.section]
		performSegue(withIdentifier: Identifier.editDream, sender: self)
		print("You tapped cell number \(indexPath.section).")
	}

    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
		if editingStyle == .delete {
			self.dreams.remove(at: (indexPath as NSIndexPath).row)
			tableView.deleteRows(at: [indexPath], with: .fade)
			
			/* We save the modifications into the local storage */
			//self.dreamsService.dreams = self.dreams
			//self.dreamsService.saveDreams()
		}
    }
	
	@IBAction func unwindToDreams(_ sender: UIStoryboardSegue) {
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
			dreamViewController.dream = self.selectedDream
			print(selectedDream.description)
		}
    }

}
