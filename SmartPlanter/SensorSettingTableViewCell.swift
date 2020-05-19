//
//  SensorSettingTableViewCell.swift
//  SmartPlanter
//
//  Created by Harri on 5/18/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit


class SensorSettingTableViewCell: UITableViewCell {


    var title: UILabel = {
        var lable = UILabel()
        lable.textAlignment = .left
        lable.textColor = UIColor.black
        return lable
    }()
    
    var textField: UITextField = {
        var textField = UITextField()
        textField.textAlignment = .left
        textField.textColor = .black
        return textField
    }()
    
    var button: UIButton = {
        var button = UIButton()
        button.tintColor = UIColor.blue
        button.setTitleColor(.blue, for: .normal)
        button.setTitle("Enable", for: .normal)
        return button
    }()
    
//    var descriptionTitle: UILabel {
//        var label = UILabel()
//        label.textColor = .gray
//        label.text = runnin
//    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.initializeView()
    }
    
    func initializeView() {
        self.addSubview(title)
        self.addSubview(textField)
        self.addSubview(button)
        self.title.translatesAutoresizingMaskIntoConstraints = false
        self.title.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        self.title.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.textField.translatesAutoresizingMaskIntoConstraints = false
        self.textField.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.textField.leftAnchor.constraint(equalTo: self.title.rightAnchor,constant: 15).isActive = true
        self.textField.rightAnchor.constraint(greaterThanOrEqualTo: self.button.leftAnchor, constant: -15).isActive = true
        
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
