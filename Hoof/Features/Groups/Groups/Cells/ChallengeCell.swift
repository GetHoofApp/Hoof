//
//  ChallengeCell.swift
//  Groups
//
//  Created by Sameh Mabrouk on 22/11/2021.
//

import UIKit

class ChallengeCell: UICollectionViewCell {
    
    static let reuseIdentifer = "photo-item-cell-reuse-identifier"
    
    private lazy var groupBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .white
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var groupIconBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
        view.layer.cornerRadius = 2
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = #imageLiteral(resourceName: "fan1")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    private lazy var challengeTitlelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var challengeDescriptionlabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var challengeDatelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .left
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private lazy var callToActionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Join", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(challengeTitle: String, challengeDescription: String, challengeDate: String, image: UIImage, backgroundColor: UIColor) {
        challengeTitlelabel.text = challengeTitle
        challengeDescriptionlabel.text = challengeDescription
        challengeDatelabel.text = challengeDate
        icon.image = image
        groupIconBackgroundView.backgroundColor = backgroundColor
    }
}

// MARK: - Setup UI

private extension ChallengeCell {
    
    func setupUI() {
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(groupBackgroundView)
        contentView.addSubview(groupIconBackgroundView)
        contentView.addSubview(icon)
        contentView.addSubview(challengeTitlelabel)
        contentView.addSubview(challengeDescriptionlabel)
        contentView.addSubview(challengeDatelabel)
        contentView.addSubview(callToActionButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            groupBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            groupBackgroundView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            groupBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            groupBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            groupIconBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            groupIconBackgroundView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            groupIconBackgroundView.widthAnchor.constraint(equalToConstant: 37),
            groupIconBackgroundView.heightAnchor.constraint(equalToConstant: 37),
            
            icon.centerXAnchor.constraint(equalTo: groupIconBackgroundView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: groupIconBackgroundView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 15),
            icon.heightAnchor.constraint(equalToConstant: 15),
//
            challengeTitlelabel.topAnchor.constraint(equalTo: groupIconBackgroundView.bottomAnchor, constant: 10),
            challengeTitlelabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            challengeTitlelabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            challengeTitlelabel.heightAnchor.constraint(equalToConstant: 40),
//
            challengeDescriptionlabel.topAnchor.constraint(equalTo: challengeTitlelabel.bottomAnchor, constant: 10),
            challengeDescriptionlabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            challengeDescriptionlabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            challengeDescriptionlabel.heightAnchor.constraint(equalToConstant: 30),
//
            challengeDatelabel.topAnchor.constraint(equalTo: challengeDescriptionlabel.bottomAnchor, constant: 0),
            challengeDatelabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
            challengeDatelabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            challengeDatelabel.heightAnchor.constraint(equalToConstant: 40),
//
            callToActionButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 10),
            callToActionButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            callToActionButton.heightAnchor.constraint(equalToConstant: 32),
            callToActionButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
