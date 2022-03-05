//
//  FindFriendsTableViewSectionHeader.swift
//  FindFriends
//
//  Created by Sameh Mabrouk on 01/03/2022.
//

import UIKit
import Core
import RxSwift
import RxCocoa

public class FindFriendsTableViewSectionHeader: UITableViewHeaderFooterView {
    
    private lazy var countLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "65 AHLETES TO FOLLOW"
        label.font = UIFont.systemFont(ofSize: 12)
//        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var followOrUnfollowButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Follow All", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(self.followOrUnfollowButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var separatorView: Separator = {
        let separator = Separator(frame: .zero)
        separator.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()
    
    var followOrUnfollowButtonTap: ControlEvent<Void> {
        return followOrUnfollowButton.rx.tap
    }
    
    var areAllSuggestedAthletesFollowed = false
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UIButton Action
    @objc func followOrUnfollowButtonAction(_ button: UIButton) {
        if areAllSuggestedAthletesFollowed {
            areAllSuggestedAthletesFollowed = false
            followOrUnfollowButton.backgroundColor = .clear
            followOrUnfollowButton.setTitleColor(.black, for: .normal)
            followOrUnfollowButton.setTitle("Follow All", for: .normal)
            
        } else {
            areAllSuggestedAthletesFollowed = true
            followOrUnfollowButton.backgroundColor = .black
            followOrUnfollowButton.setTitleColor(.white, for: .normal)
            followOrUnfollowButton.setTitle("Following All", for: .normal)
        }
    }
}

// MARK: - Setup UI

private extension FindFriendsTableViewSectionHeader {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        tintColor = UIColor(red: 247/255, green: 247/255, blue: 249/255, alpha: 1.0)
    }
    
    func setupSubviews() {
        addSubview(countLabel)
        addSubview(followOrUnfollowButton)
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            countLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            countLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),

            followOrUnfollowButton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            followOrUnfollowButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            followOrUnfollowButton.heightAnchor.constraint(equalToConstant: 35),
            followOrUnfollowButton.widthAnchor.constraint(equalToConstant: 100),
            
            separatorView.leftAnchor.constraint(equalTo: leftAnchor),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

