//
//  AthleteActivitiesCell.swift
//  Profile
//
//  Created by Sameh Mabrouk on 28/01/2022.
//

import Foundation
import UIKit
import Core

class AthleteActivitiesCell: UITableViewCell, Dequeueable {
    
    private lazy var activitiesImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "soccer")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "chevron")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}

extension AthleteActivitiesCell {
    
    func setupUI() {
        backgroundColor = .white
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(activitiesImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(chevronImageView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activitiesImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
//            activitiesImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 18),
            activitiesImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            activitiesImageView.widthAnchor.constraint(equalToConstant: 20),
            activitiesImageView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            titleLabel.leftAnchor.constraint(equalTo: activitiesImageView.rightAnchor, constant: 11),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
                        
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 2),
            subtitleLabel.leftAnchor.constraint(equalTo: titleLabel.leftAnchor, constant: 0),
            subtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -14),
            
            chevronImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            chevronImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            chevronImageView.widthAnchor.constraint(equalToConstant: 7),
            chevronImageView.heightAnchor.constraint(equalToConstant: 12),
        ])
    }
}
