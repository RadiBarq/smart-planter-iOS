//
//  SecondViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/9/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import SocketIO
import UIKit

class DashBoardViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView!
    var jobs = [Job]()
    var jobsValue = [String]()


    
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
    
        
        NetworkModel.gePlanter() { response in
            switch response {
            case .success(let result):
                self.jobs = result.jobs
                self.jobs.remove(at: 1)
                for job in self.jobs {
                    switch job.name {
                    case "WaterLevel":
                        //self.jobsValue.append(String(result.WaterLevel.rounded()) + " cm")
                        self.jobsValue.append("10cm")
                    case "Moisture":
                        self.jobsValue.append(String(result.Moisture.rounded()) + " %")
                    case "Temperature":
                        self.jobsValue.append(String(result.Temperature.rounded()) + " °c")
                    case "Humidity":
                        self.jobsValue.append(String(result.Humidity.rounded()) + " %")
                    case "Camera", "images":
                        self.jobsValue.append("")
                    case "Brightness":
                        self.jobsValue.append(String(result.Lighting[0].rounded()) + " %")
                    default:
                        break
                    }
                }
                
                DispatchQueue.main.sync {
                    self.collectionView.reloadData()
                }
            case .failure(let error):
                let alertControler = UIAlertController(title: "Something Wrong Happened", message: "Connection Error!", preferredStyle: .alert)
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                      alertControler.addAction(alertAction)
                self.present(alertControler, animated: true, completion: nil)
                print(error)
            }
        }
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
        self.jobs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: "DashboardCollectionViewCell", for: indexPath) as! DashBoardCollectionViewCell
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 15
        cell.titleLabel.text = self.jobs[indexPath.row].name
        cell.descriptionLabel.text = self.jobsValue[indexPath.row]
        cell.layer.cornerRadius = 15
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 180, height: 180)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (self.jobs[indexPath.row].name == "images") {
            let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(identifier: "ImagesTableViewController") as! ImagesTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = SensorDetailsViewController(sensorName: self.jobs[indexPath.row].name, sensorURL: self.jobs[indexPath.row].url)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    

}

