//
//  ImagesTableViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/18/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit
import ImageViewer_swift

class ImagesTableViewController: UITableViewController {

    let images = ["https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/jade-planting-growing.jpg?itok=XAWRrD6K", "https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/jade-planting-growing.jpg?itok=XAWRrD6K", "https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/jade-planting-growing.jpg?itok=XAWRrD6K", "https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/jade-planting-growing.jpg?itok=XAWRrD6K"]
        
    let timesTaken = ["14 November 2005", "14 November 2005", "14 November 2005", "14 November 2005"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plant Growth", style: .plain, target: self, action: #selector(self.didClickPlantGrowth))
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.images.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        do {
            let url = URL(string: self.images[indexPath.row])
          //  let data = try Data(contentsOf: url!)
            cell.imageView?.sd_internalSetImage(with: url, placeholderImage: nil, options: .transformAnimatedImage, context: .none, setImageBlock: .none, progress: .none, completed: .none)
            cell.imageView?.setupImageViewer()
        }
        catch{
            print(error)
        }
        cell.textLabel?.text = self.timesTaken[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func didClickPlantGrowth() {
        let vc = SensorDetailsViewController(sensorName: "Plant Growth")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
