//
//  LocationTableViewCell.swift
//  Aispl-Task
//
//  Created by Karthi on 09/07/24.
//

import UIKit

class LocationTableViewCell: UITableViewCell {

    let headingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let subheadingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(headingLabel)
        contentView.addSubview(subheadingLabel)
        
        NSLayoutConstraint.activate([
            headingLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            headingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            headingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            
            subheadingLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 4),
            subheadingLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            subheadingLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            subheadingLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
