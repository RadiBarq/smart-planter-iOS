//
//  FirstViewController.swift
//  SmartPlanter
//
//  Created by Harri on 5/9/20.
//  Copyright © 2020 Harri. All rights reserved.
//
import UIKit


class SettingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    var toolBar = UIToolbar()
    var picker  = UIPickerView()
    
    // table view
    let tableView = UITableView()
    let itemsTitle = ["Username", "Planter Type", "Jobs Setting", "Logout"]
    var itemsDescription = [NetworkModel.userName, NetworkModel.planterType, "", ""]
    var pickerViewData = [Plant]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Settings"
        
        // Do any additional setup after loading the view.
        self.initalizeTableView()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        NetworkModel.getPlantsType { response in
            switch response {
            case .success(let result):
                self.pickerViewData = result
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.itemsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = self.tableView.dequeueReusableCell(withIdentifier: "UITableViewCell")
        cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        cell?.textLabel?.text = itemsTitle[indexPath.row]
        cell?.detailTextLabel?.text = itemsDescription[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            break
        case 1:
            showPickerView()
            break
        case 2:
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(identifier: "SensorsSettingTableViewController") as! SensorsSettingTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
            break
        case 3:
            break
        default:
            break
        }
    }

    private func showPickerView() {
        picker = UIPickerView.init()
        picker.delegate = self
        picker.backgroundColor = UIColor.white
        picker.setValue(UIColor.black, forKey: "textColor")
        picker.autoresizingMask = .flexibleWidth
        picker.contentMode = .center
        picker.frame = CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 300)
        self.view.addSubview(picker)
        
        toolBar = UIToolbar.init(frame: CGRect.init(x: 0.0, y: UIScreen.main.bounds.size.height - 300, width: UIScreen.main.bounds.size.width, height: 50))
        toolBar.barStyle = .default
        toolBar.items = [UIBarButtonItem.init(title: "Done", style: .done, target: self, action: #selector(onDoneButtonTapped))]
        self.view.addSubview(toolBar)
    }
    
    @objc func onDoneButtonTapped() {
        toolBar.removeFromSuperview()
        picker.removeFromSuperview()
    }
    
    private func initalizeTableView() {
        self.view.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        self.tableView.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        self.pickerViewData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.pickerViewData[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.itemsDescription[1] = pickerViewData[row].name
        self.tableView.reloadData()
    }
}


