//
//  CreateChallengeView.swift
//  Groups
//
//  Created by Sameh Mabrouk on 22/11/2021.
//

import UIKit

class CreateChallengeView: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage( #imageLiteral(resourceName: "Add"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false

        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Create a Group Challenge"
        label.font = UIFont.boldSystemFont(ofSize: 10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Start a challenge with friends"
        label.font = UIFont.systemFont(ofSize: 10)
        label.textColor = UIColor(red: 151/255, green: 151/255, blue: 151/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var footerView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 170/255, green: 172/255, blue: 175/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup UI

private extension CreateChallengeView {
    
    func setupUI() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(button)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(footerView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            button.leftAnchor.constraint(equalTo: leftAnchor, constant: 13),
            button.widthAnchor.constraint(equalToConstant: 15),
            button.heightAnchor.constraint(equalToConstant: 15),
            
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 8),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 1),
            subtitleLabel.leftAnchor.constraint(equalTo: button.rightAnchor, constant: 8),
            subtitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            subtitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            footerView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 10),
            footerView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            footerView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            footerView.heightAnchor.constraint(equalToConstant: 0.2)
        ])
    }
}



