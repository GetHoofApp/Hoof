//
//  NearbyAthleteCell.swift
//  Map
//
//  Created by Sameh Mabrouk on 16/11/2021.
//

import UIKit
import Core

class ActivityCell: UITableViewCell, Dequeueable {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user1")
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jessica"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func setup(image: UIImage, userName: String) {
        self.image.image = image
        userNameLabel.text = userName
    }
}

// MARK: - Setup UI

private extension ActivityCell {
    
    func setupUI() {
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
        
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
    
    func setupSubviews() {
        addSubview(image)
        addSubview(userNameLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            image.widthAnchor.constraint(equalToConstant: 76),
            image.heightAnchor.constraint(equalToConstant: 77),
            image.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
//            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 11),
            userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            userNameLabel.heightAnchor.constraint(equalToConstant: 22),
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}


