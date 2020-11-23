//
//  StatisticsTableViewCell.swift
//  Timer
//
//  Created by Ingrid on 28/09/2020.
//  Copyright © 2020 Ingrid. All rights reserved.
//

import UIKit

class StatisticsTableViewCell: UITableViewCell {
    
    let typeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .red
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let label1: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.darkText)
        label.textAlignment = .center
        label.font = Constants.mainFont
        return label
    }()
    
    let label2: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.darkText)
        label.textAlignment = .center
        label.font = Constants.mainFont
        
        return label
    }()
    
    let label3: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.darkText)
        label.textAlignment = .center
        label.font = Constants.mainFont
        return label
    }()
    
    let label4: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.darkText)
        label.textAlignment = .center
        label.font = Constants.mainFont
        return label
    }()
    
    let label5: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.numberOfLines = 1
        label.textColor = UIColor(named: Constants.darkText)
        label.textAlignment = .right
        label.font = Constants.mainFontSmall
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.contentView.addSubview(typeIcon)
        self.contentView.addSubview(label1)
        self.contentView.addSubview(label2)
        self.contentView.addSubview(label3)
        self.contentView.addSubview(label4)
        label4.addSubview(label5)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConstraints() {
        
        typeIcon.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        typeIcon.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        typeIcon.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        typeIcon.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.15).isActive = true
        
        label1.leadingAnchor.constraint(equalTo: typeIcon.trailingAnchor).isActive = true
        label1.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label1.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label1.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.1).isActive = true

        label2.leadingAnchor.constraint(equalTo: label1.trailingAnchor).isActive = true
        label2.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label2.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label2.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
        
        label3.leadingAnchor.constraint(equalTo: label2.trailingAnchor).isActive = true
        label3.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label3.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.250).isActive = true
        
        label4.leadingAnchor.constraint(equalTo: label3.trailingAnchor).isActive = true
        label4.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        label4.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        label4.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        
        label5.leadingAnchor.constraint(equalTo: label4.leadingAnchor).isActive = true
        label5.topAnchor.constraint(equalTo: label4.topAnchor).isActive = true
        label5.heightAnchor.constraint(equalTo: label4.heightAnchor, multiplier: 0.2).isActive = true
        label5.trailingAnchor.constraint(equalTo: label4.trailingAnchor, constant: -5).isActive = true

    }
}
