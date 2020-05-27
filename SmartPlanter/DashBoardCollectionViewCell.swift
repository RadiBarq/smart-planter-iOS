//
//  DashBoardCollectionViewCell.swift
//  SmartPlanter
//
//  Created by Harri on 5/16/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class DashBoardCollectionViewCell: UICollectionViewCell {
    var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    var descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 50/255, green: 168/255, blue: 81/255, alpha: 1)
        self.addSubview(descriptionLabel)
        self.descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        self.descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.descriptionLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.descriptionLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        self.titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
        self.titleLabel.bottomAnchor.constraint(equalTo: self.descriptionLabel.topAnchor, constant: -10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
