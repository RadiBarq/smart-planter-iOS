//
//  ImagesTableViewControllerTableViewCell.swift
//  SmartPlanter
//
//  Created by Harri on 5/20/20.
//  Copyright © 2020 Harri. All rights reserved.
//

import UIKit

class ImagesTableViewControllerTableViewCell: UITableViewCell {
    
    // Title
    let customTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.textAlignment = .left
        return label
    }()

    /// image
    let customImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addSubview(customImage)
        customImage.translatesAutoresizingMaskIntoConstraints = false
        customImage.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 15).isActive = true
        customImage.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        customImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        customImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        self.addSubview(customTitle)
        self.customTitle.translatesAutoresizingMaskIntoConstraints = false
        self.customTitle.leftAnchor.constraint(equalTo: self.customImage.rightAnchor, constant: 15).isActive = true
        self.customTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.customTitle.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
