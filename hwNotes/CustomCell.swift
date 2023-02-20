//
//  CustomCell.swift
//  hwNotes
//
//  Created by Anthony on 12.02.2023.
//

import UIKit

class CustomCell: UITableViewCell {

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.backgroundColor = .orange
        return label
    }()
    let noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .light)
        label.backgroundColor = .green
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
        [titleLabel, noteLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.textAlignment = .center
            contentView.addSubview( $0 )
        }
        
        NSLayoutConstraint.activate([
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            titleLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.5),
            
            noteLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            noteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            noteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            noteLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }
    
    func configere(content: Contents) {
        titleLabel.text = content.dataAndTime
        noteLabel.text = content.location
    }
}
