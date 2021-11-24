//
//  GroupCollectionViewCell.swift
//  Groups
//
//  Created by Sameh Mabrouk on 19/11/2021.
//

import UIKit

class GroupCollectionViewCell: UICollectionViewCell {
    
    private lazy var groupBackgroundView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
        view.layer.cornerRadius = 5
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var groupNamelabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    private lazy var icon: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = #imageLiteral(resourceName: "user1")
        image.translatesAutoresizingMaskIntoConstraints = false
        
        return image
    }()
    
    override init(frame: CGRect) {
       super.init(frame: frame)
       setupUI()
    }
       
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(image: UIImage, backgroundColor: UIColor, groupName: String) {
        groupBackgroundView.backgroundColor = backgroundColor
        groupNamelabel.text = groupName
        icon.image = image
    }
}

// MARK: - Setup UI

extension GroupCollectionViewCell {
    
    func setupUI() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(groupBackgroundView)
        addSubview(icon)
        addSubview(groupNamelabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            groupBackgroundView.topAnchor.constraint(equalTo: topAnchor, constant: 0),
            groupBackgroundView.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            groupBackgroundView.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            groupBackgroundView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -32),

            icon.centerXAnchor.constraint(equalTo: groupBackgroundView.centerXAnchor),
            icon.centerYAnchor.constraint(equalTo: groupBackgroundView.centerYAnchor),
            icon.widthAnchor.constraint(equalToConstant: 40),
            icon.heightAnchor.constraint(equalToConstant: 40),
            
//            groupBackgroundView.heightAnchor.constraint(equalToConstant: 97),
            
            groupNamelabel.topAnchor.constraint(equalTo: groupBackgroundView.bottomAnchor, constant: 5),
            groupNamelabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5),
            groupNamelabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -5),
            groupNamelabel.heightAnchor.constraint(equalToConstant: 22),
//            groupNamelabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}
