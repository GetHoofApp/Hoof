//
//  ChallengeCell.swift
//  CreateChallenge
//
//  Created by Sameh Mabrouk on 24/11/2021.
//

import UIKit
import Core

class ChallengeCell: UITableViewCell, Dequeueable {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user1")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Try Group Challenges"
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Play just with your friends. Your rules, Your way! Try 4 Group Challenges for free now or subscribe for unlimeted access"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cellBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.layer.cornerRadius = 7
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0).cgColor
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(title: String, subtitle: String, icon: UIImage) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        image.image = icon
    }
}

// MARK: - Setup UI

private extension ChallengeCell {
    
    func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(cellBackgroundView)
        addSubview(image)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            cellBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            cellBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: -15),
            cellBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            
            image.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            image.leftAnchor.constraint(equalTo: cellBackgroundView.leftAnchor, constant: 12),
            image.widthAnchor.constraint(equalToConstant: 15),
            image.heightAnchor.constraint(equalToConstant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -30),
        ])
    }
}



