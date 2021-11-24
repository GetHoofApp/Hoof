//
//  ChallengesSectionHeaderView.swift
//  Groups
//
//  Created by Sameh Mabrouk on 22/11/2021.
//

import UIKit

class ChallengesSectionHeaderView: UICollectionReusableView {
    
    static let reuseIdentifier = "header-reuse-identifier"
    
    private lazy var createChallengeView: CreateChallengeView = {
        let view = CreateChallengeView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "fan1")
        return image
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recommended For You"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Based on Your activities"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

// MARK: - Setup UI

private extension ChallengesSectionHeaderView {
    
    func setupUI() {
        backgroundColor = .clear
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(createChallengeView)
        addSubview(image)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            createChallengeView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            createChallengeView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            createChallengeView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            createChallengeView.heightAnchor.constraint(equalToConstant: 52),
            
            image.topAnchor.constraint(equalTo: createChallengeView.bottomAnchor, constant: 20),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 7),
            image.widthAnchor.constraint(equalToConstant: 30),
            image.heightAnchor.constraint(equalToConstant: 30),
            
            titleLabel.topAnchor.constraint(equalTo: createChallengeView.bottomAnchor, constant: 18),
            titleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            subtitleLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 12),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 15),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20)
        ])
    }
}

