//
//  CommentCell.swift
//  Discussion
//
//  Created by Sameh Mabrouk on 13/01/2022.
//

import UIKit
import Core
import GoogleMaps
import GoogleMapsUtils

class CommentCell: UITableViewCell, Dequeueable {
    
    private var mapView: GMSMapView!
    
    private lazy var userImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player5")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Ronald Robertson"
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Today"
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor(red: 60/255, green: 60/255, blue: 67/255, alpha: 0.6)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var commentLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Love it!"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
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
    
    func configure(with comment: AthleteActivityComment) {
        commentLabel.text = comment.text
    }
}

// MARK: - Setup UI

private extension CommentCell {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(commentLabel)
        contentView.addSubview(dateLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 48),
            userImageView.heightAnchor.constraint(equalToConstant: 48),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 12),
            userNameLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -57),

            commentLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10),
            commentLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 12),
            
            dateLabel.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -36),
        ])
    }
}


