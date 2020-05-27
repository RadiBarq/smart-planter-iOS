//
//  SensorsSettingTableViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/17/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class SensorsSettingTableViewController: UITableViewController {
    
    var jobs = [Job]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Jobs Sttings"
        self.tableView.register(SensorSettingTableViewCell.self, forCellReuseIdentifier: "SensorSettingTableViewCell")
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: self, action: #selector(self.saveButtonClicked))
        
        NetworkModel.getJobs { response in
            switch response {
            case .success(let result):
                self.jobs = result
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc func saveButtonClicked() {
        var counter = 0
        var index = 0
        for job in jobs {
            let cell = self.tableView.cellForRow(at: IndexPath(row: index, section: 0)) as? SensorSettingTableViewCell
            let text = cell!.textField.text
            self.jobs[index].when_to_execute = Int(cell!.textField.text!)!
            NetworkModel.updateJobs(job: self.jobs[index]) {
                    counter += 1
                if counter == self.jobs.count {
                    DispatchQueue.main.sync {
                          self.navigationController?.popViewController(animated: true)
                    }
                }
            }
            
            index += 1
        }
    }
    

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.jobs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "SensorSettingTableViewCell", for: indexPath) as! SensorSettingTableViewCell
        cell.title.text = jobs[indexPath.row].name
        cell.textField.text = String(jobs[indexPath.row].when_to_execute)
        cell.button.tag = indexPath.row
        cell.button.setTitleColor(jobs[indexPath.row].status ? .red: .blue, for: .normal)
        cell.button.setTitle( jobs[indexPath.row].status ? "Disable": "Enable", for: .normal)
        cell.button.addTarget(self, action: #selector(self.enableClicked), for: .touchUpInside)
        return cell
    }
    
    @objc func enableClicked(sender: UIButton) {
        self.jobs[sender.tag].status = !self.jobs[sender.tag].status
        self.tableView.reloadRows(at: [IndexPath(row: sender.tag, section: 0)], with: .automatic)
    }
    
    
    
}
