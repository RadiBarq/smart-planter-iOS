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

    var images = [Image]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Plant Growth", style: .plain, target: self, action: #selector(self.didClickPlantGrowth))
        self.tableView.register(ImagesTableViewControllerTableViewCell.self, forCellReuseIdentifier: "ImagesTableViewControllerTableViewCell")
        
        NetworkModel.getImages() { response in
            switch response {
            case .success(let result):
                self.images = result
                DispatchQueue.main.sync {
                    self.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImagesTableViewControllerTableViewCell", for: indexPath) as! ImagesTableViewControllerTableViewCell
                do {
                 let url = URL(string: self.images[indexPath.row].image)
                 let data = try Data(contentsOf: url!)
                // cell.imageView?.sd_internalSetImage(with: url, placeholderImage: nil, options:  [.transformAnimatedImage, .avoidAutoSetImage], context: .none, setImageBlock: .none, progress: .none, completed: .none)
                 cell.customImage.image = UIImage(data: data)
                 cell.customImage.setupImageViewer()
                } catch(let error) {
                    print(error)
                }
        
        cell.customTitle.text = self.images[indexPath.row].current_time
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    @objc func didClickPlantGrowth() {
        let vc = SensorDetailsViewController(sensorName: "Plant Growth", sensorURL: "")
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
