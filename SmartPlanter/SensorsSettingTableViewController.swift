//
//  SensorsSettingTableViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/17/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class SensorsSettingTableViewController: UITableViewController {
    
    let sensors = ["Water Level Running Time", "Moisture Running Time", "Temprature Running Time", "Humidity Running Time"]
    let sensorsData = [20, 30 , 40, 50, 60]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    
        self.tableView.register(SensorSettingTableViewCell.self, forCellReuseIdentifier: "SensorSettingTableViewCell")
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveButtonClicked))
    }
    
    
    @objc func saveButtonClicked() {
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.sensors.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SensorSettingTableViewCell", for: indexPath) as! SensorSettingTableViewCell
        cell.title.text = sensors[indexPath.row]
        cell.textField.text = String(sensorsData[indexPath.row])
        cell.button.tag = indexPath.row
        cell.button.addTarget(self, action: #selector(self.enableClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func enableClicked(sender: UIButton) {
        print(sender.tag)
    }
}
