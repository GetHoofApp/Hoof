//
//  ActivityCell.swift
//  Home
//
//  Created by Sameh Mabrouk on 09/11/2021.
//

import UIKit
import Core

class ActivityCell: UITableViewCell, Dequeueable {
    
    private lazy var image: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user1")
        return image
    }()
    
    private lazy var image1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "fan1")
        return image
    }()
    
    private lazy var image2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "fan2")
        return image
    }()
    
    private lazy var image3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "user1")
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jessica"
        label.font = .boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "OCTOBER 26, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday Match"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var spacing: CGFloat = 8.0

    private lazy var distanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "30 KM"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paceLabel: UILabel = {
        let label = UILabel()
        label.text = "Pace"
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "5 /Km"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var paceStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing

        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
        
    private lazy var heatmapImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "heatmap")
        
        return image
    }()
    
    private lazy var kudosLabel: UILabel = {
        let label = UILabel()
        label.text = "You and 4 others gave kudos"
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    func configure(name: String, userImage: UIImage, date: String, activityName: String, distance: String, pace: String) {
        userNameLabel.text = name
        dateLabel.text = date
        image.image = userImage
        activityTitleLabel.text = activityName
        distanceValueLabel.text = distance
        paceValueLabel.text = pace
    }
}

// MARK: - Setup UI

private extension ActivityCell {
    
    func setupUI() {
        backgroundColor = .white
        setupSubviews()
        setupConstraints()
        
        image.layer.cornerRadius = image.frame.size.width / 2
        image.clipsToBounds = true
    }
    
    func setupSubviews() {
        addSubview(image)
        addSubview(userNameLabel)
        addSubview(dateLabel)
        addSubview(activityTitleLabel)
        
        distanceStackView.addArrangedSubview(distanceLabel)
        distanceStackView.addArrangedSubview(distanceValueLabel)
        
        paceStackView.addArrangedSubview(paceLabel)
        paceStackView.addArrangedSubview(paceValueLabel)
        
        addSubview(distanceStackView)
        addSubview(divider)
        addSubview(paceStackView)
        
        addSubview(heatmapImage)
        
        addSubview(image1)
        addSubview(image2)
        addSubview(image3)
        
        addSubview(kudosLabel)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            image.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            image.widthAnchor.constraint(equalToConstant: 76),
            image.heightAnchor.constraint(equalToConstant: 77),
            
            userNameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: image.rightAnchor, constant: 11),
            userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            userNameLabel.heightAnchor.constraint(equalToConstant: 22),
            
            
            dateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
            dateLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor, constant: 0),
            dateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            dateLabel.heightAnchor.constraint(equalToConstant: 42),
            
            activityTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 16),
            activityTitleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),
            activityTitleLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            activityTitleLabel.heightAnchor.constraint(equalToConstant: 42),

            distanceStackView.leftAnchor.constraint(equalTo: leftAnchor, constant: 28),
            distanceStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 16),
//            distanceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            divider.leftAnchor.constraint(equalTo: distanceStackView.rightAnchor, constant: 11),
            divider.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 16),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 38),

            paceStackView.leftAnchor.constraint(equalTo: divider.leftAnchor, constant: 28),
            paceStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 16),
//            paceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            heatmapImage.topAnchor.constraint(equalTo: paceStackView.bottomAnchor, constant: 10),
            heatmapImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 0),
            heatmapImage.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            heatmapImage.heightAnchor.constraint(equalToConstant: 155),
//            heatmapImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            image1.topAnchor.constraint(equalTo: heatmapImage.bottomAnchor, constant: 12),
            image1.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 22),
            image1.widthAnchor.constraint(equalToConstant: 38),
            image1.heightAnchor.constraint(equalToConstant: 42),
            image1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            image2.topAnchor.constraint(equalTo: heatmapImage.bottomAnchor, constant: 12),
            image2.leadingAnchor.constraint(equalTo: image1.leadingAnchor, constant: 30),
            image2.widthAnchor.constraint(equalToConstant: 38),
            image2.heightAnchor.constraint(equalToConstant: 42),
            image2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            image3.topAnchor.constraint(equalTo: heatmapImage.bottomAnchor, constant: 12),
            image3.leadingAnchor.constraint(equalTo: image2.leadingAnchor, constant: 30),
            image3.widthAnchor.constraint(equalToConstant: 38),
            image3.heightAnchor.constraint(equalToConstant: 42),
            image3.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
            kudosLabel.topAnchor.constraint(equalTo: heatmapImage.bottomAnchor, constant: 12),
            kudosLabel.leftAnchor.constraint(equalTo: image3.rightAnchor, constant: 16),
            kudosLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: 0),
            kudosLabel.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}


