//
//  SettingsTableViewController.swift
//  OniDream
//
//  Created by Mathieu Bourmaud on 2017-09-13.
//  Copyright © 2017 Mathieu Bourmaud. All rights reserved.
//

import UIKit

class SettingsController: UITableViewController {

    var numberOfRowsForSection: [Int:Int] = [0:1, 1:3, 2:3, 3:1, 4:1]
    var sectionTitle: [Int:String] = [0:"Bluetooth", 1:"Alarm", 2:"Sound", 3:"Vibration", 4:"Led"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.backgroundView = View(frame: self.tableView.bounds)
        self.tableView.separatorStyle = .none

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 40))
        
        headerView.addSubview(headerLabel)
        
        headerLabel.snp.makeConstraints { (make) -> Void in
            make.left.equalTo(headerView).offset(Style.margin)
            make.right.equalTo(headerView)
            make.bottom.equalTo(headerView)
            make.top.equalTo(headerView)
        }
        
        headerView.backgroundColor = Color.white80
        
        return headerView
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = Color.white30
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return self.numberOfRowsForSection.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        //return self.numberOfRowsForSection[section - 1]!
        
        print("Pour la section: \(section), rows: \(String(describing: self.numberOfRowsForSection[section]))")
        return self.numberOfRowsForSection[section]!
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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
