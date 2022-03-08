//
//  FriendsCell.swift
//  FindFriends
//
//  Created by Sameh Mabrouk on 24/02/2022.
//

import UIKit
import Core
import Kingfisher
import RxCocoa

class FriendsCell: UITableViewCell, Dequeueable {
        
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "athlete-placeholder")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Ronald Robertson"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followOrUnfollowButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Follow", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.followOrUnfollowButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var detailsLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "You have mutual friends on Hoof"
        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        label.font = UIFont.systemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var followOrUnfollowButtonTap: ControlEvent<Void> {
        return followOrUnfollowButton.rx.tap
    }
    
    var user: User!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
       
        user = nil
    }
    
    // MARK: - UIButton Action
    @objc func followOrUnfollowButtonAction(_ button: UIButton) {
        if user.isAthleteFollowed {
            user.isAthleteFollowed = false            
            followOrUnfollowButton.backgroundColor = .clear
            followOrUnfollowButton.setTitleColor(.black, for: .normal)
            followOrUnfollowButton.setTitle("Follow", for: .normal)
            
        } else {
            user.isAthleteFollowed = true
            followOrUnfollowButton.backgroundColor = .black
            followOrUnfollowButton.setTitleColor(.white, for: .normal)
            followOrUnfollowButton.setTitle("Following", for: .normal)
        }
    }
    
    func configure(with suggestedAthlete: User) {
        if !suggestedAthlete.photoURL.isEmpty, let userPhotoURL = URL(string: Config.baseURL + "/media/" + suggestedAthlete.photoURL) {
            let processor = RoundCornerImageProcessor(cornerRadius: userImageView.frame.height / 2)
            userImageView.kf.indicatorType = .activity
            userImageView.kf.setImage(
                with: userPhotoURL,
                placeholder: UIImage(named: "athlete-placeholder"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])            
        } else {
            userImageView.image = #imageLiteral(resourceName: "athlete-placeholder")
        }
    
        userNameLabel.text = suggestedAthlete.firstName + " " + suggestedAthlete.lastName

        suggestedAthlete.isAthleteFollowed ? followOrUnfollowButton.setTitle("Unfollow", for: .normal) : followOrUnfollowButton.setTitle("Follow", for: .normal)
        
        if suggestedAthlete.isAthleteFollowed {
            followOrUnfollowButton.backgroundColor = .black
            followOrUnfollowButton.setTitleColor(.white, for: .normal)
            followOrUnfollowButton.setTitle("Following", for: .normal)
        } else {
            followOrUnfollowButton.backgroundColor = .clear
            followOrUnfollowButton.setTitleColor(.black, for: .normal)
            followOrUnfollowButton.setTitle("Follow", for: .normal)
        }
        
        user = suggestedAthlete
    }
}

// MARK: - Setup UI

private extension FriendsCell {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(detailsLabel)
        contentView.addSubview(followOrUnfollowButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 48),
            userImageView.heightAnchor.constraint(equalToConstant: 48),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 12),
            userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40),

            detailsLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            detailsLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 12),
            
            followOrUnfollowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followOrUnfollowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            followOrUnfollowButton.heightAnchor.constraint(equalToConstant: 35),
            followOrUnfollowButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
}


