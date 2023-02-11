//
//  CustomCell.swift
//  hwNotes
//
//  Created by Anthony on 12.02.2023.
//

import UIKit

class CustomCell: UITableViewCell {

    let dataAndTimeLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.backgroundColor = .orange
        return label
    }()
    let locationLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
//        label.backgroundColor = .green
        return label
    }()
    let massageLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
//        label.backgroundColor = .brown
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        [dataAndTimeLabel, locationLabel, massageLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.font = UIFont.systemFont(ofSize: 14)
            $0.textAlignment = .center
            contentView.addSubview( $0 )
        }
        
        NSLayoutConstraint.activate([
            
            dataAndTimeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            dataAndTimeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            dataAndTimeLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            dataAndTimeLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            locationLabel.topAnchor.constraint(equalTo: dataAndTimeLabel.bottomAnchor, constant: 0),
            locationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            locationLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            
            massageLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            massageLabel.leadingAnchor.constraint(equalTo: dataAndTimeLabel.trailingAnchor, constant: 8),
            massageLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            massageLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func configere(content: Contents) {
        dataAndTimeLabel.text = content.dataAndTime
        locationLabel.text = content.location
        massageLabel.text = content.massage
    }
}
