//
//  SecondViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/9/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class DashBoardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    var collectionView: UICollectionView!
    var titleItems = ["Water Level", "Temprature", "Humidity", "Moisture", "Photos", "Water Level", "Temprature", "Humidity", "Moisture", "Photos"]
    var descroptionItems = ["22", "25c", "22", "50", "", "22", "25c", "22", "50", ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Dashboard"
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        self.collectionView.setCollectionViewLayout(flowLayout, animated: true)
        self.view.addSubview(self.collectionView)
        initializeCollectionView()
        self.collectionView.register(DashBoardCollectionViewCell.self, forCellWithReuseIdentifier: "DashboardCollectionViewCell")
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        // Do any additional setup after loading the view.
    }

    private func initializeCollectionView() {
        self.collectionView.backgroundColor = .clear
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.leftAnchor.constraint(equalTo: self.view.leftAnchor,constant: 0).isActive = true
        self.collectionView.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: 0).isActive = true
        self.collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.titleItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashBoardCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        cell.titleLabel.text = self.titleItems[indexPath.row]
        cell.descriptionLabel.text = self.descroptionItems[indexPath.row]
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (indexPath.row == 4) {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ImagesTableViewController") as! ImagesTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SensorDetailsViewController(sensorName: self.titleItems[indexPath.row])
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}

