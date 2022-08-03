//
//  AthleteDetailsCell.swift
//  Profile
//
//  Created by Sameh Mabrouk on 27/01/2022.
//

import Foundation
import UIKit
import Core
import RxSwift
import RxCocoa
import Kingfisher

class AthleteDetailsCell: UITableViewCell, Dequeueable {
    
    public var spacing: CGFloat = 8.0

    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var userLocationLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followersLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Followers"
        label.textColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followersNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followersStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var followingLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Following"
        label.textColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followingNumberLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var followingStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var editProfileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Edit", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.backgroundColor = .black
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var editButtonTap: ControlEvent<Void> {
        return editProfileButton.rx.tap
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(userImageURL: String?, userName: String, userLocation: String, followers: String, following: String) {
		let placeholder = #imageLiteral(resourceName: "athlete-placeholder")
		if let userPhotoURL = URL(string: userImageURL ?? "") {
			let processor = RoundCornerImageProcessor(cornerRadius: 25, targetSize: CGSize(width: 50, height: 50))
			userImageView.kf.indicatorType = .activity
			userImageView.kf.setImage(
				with: userPhotoURL,
				placeholder: placeholder,
				options: [
					.processor(processor),
					.scaleFactor(UIScreen.main.scale),
					.transition(.fade(1)),
					.cacheOriginalImage
				])
		} else {
			userImageView.image = placeholder
		}
        userNameLabel.text = userName
        userLocationLabel.text = userLocation
        followersNumberLabel.text = followers
        followingNumberLabel.text = following
    }
}

extension AthleteDetailsCell {
    
    func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(userLocationLabel)
        
        followersStackView.addArrangedSubview(followersLabel)
        followersStackView.addArrangedSubview(followersNumberLabel)

        followingStackView.addArrangedSubview(followingLabel)
        followingStackView.addArrangedSubview(followingNumberLabel)

        contentView.addSubview(followersStackView)
        contentView.addSubview(divider)
        contentView.addSubview(followingStackView)
        contentView.addSubview(editProfileButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 75),
            userImageView.heightAnchor.constraint(equalToConstant: 75),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 11),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
                        
            userLocationLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7),
            userLocationLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor, constant: 0),
            userLocationLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            userLocationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -120),

            followersStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            followersStackView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 28),

            divider.leftAnchor.constraint(equalTo: followersStackView.rightAnchor, constant: 5),
            divider.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 42),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 25),

            followingStackView.leftAnchor.constraint(equalTo: divider.leftAnchor, constant: 12),
            followingStackView.topAnchor.constraint(equalTo: userImageView.bottomAnchor, constant: 28),
            followingStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            
            editProfileButton.centerYAnchor.constraint(equalTo: followingStackView.centerYAnchor),
            editProfileButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            editProfileButton.heightAnchor.constraint(equalToConstant: 30),
            editProfileButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}
