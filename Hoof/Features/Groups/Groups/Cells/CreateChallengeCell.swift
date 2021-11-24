//
//  CreateChallengeCell.swift
//  Groups
//
//  Created by Sameh Mabrouk on 19/11/2021.
//

import UIKit
import Core

class CreateChallengeCell: UITableViewCell, Dequeueable {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Try Group Challenges"
        label.font = UIFont.systemFont(ofSize: 36)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Play just with your friends. Your rules, Your way! Try 4 Group Challenges for free now or subscribe for unlimeted access"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 3
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var callToActionButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Create a Group Challenge", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 243/255, green: 246/255, blue: 250/255, alpha: 1.0)
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
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        layoutMargins = UIEdgeInsetsMake(8, 0, 8, 0)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        layoutMargins = contentView.frame.inset(by: UIEdgeInsets(top: 100, left: 10, bottom: 100, right: 10))
    }
}

// MARK: - Setup UI

private extension CreateChallengeCell {
    
    func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(callToActionButton)
        addSubview(footerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 40),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -160),
            titleLabel.heightAnchor.constraint(equalToConstant: 120),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 0),
            subtitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            subtitleLabel.heightAnchor.constraint(equalToConstant: 71),
            
            callToActionButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            callToActionButton.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            callToActionButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16),
            callToActionButton.heightAnchor.constraint(equalToConstant: 39),
//            callToActionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            footerView.topAnchor.constraint(equalTo: callToActionButton.bottomAnchor, constant: 20),
            footerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            footerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            footerView.heightAnchor.constraint(equalToConstant: 7),
            footerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}



