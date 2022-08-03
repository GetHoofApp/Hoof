//
//  ActivityDetailsCell.swift
//  Discussion
//
//  Created by Sameh Mabrouk on 13/01/2022.
//

import UIKit
import Core
import GoogleMaps
import GoogleMapsUtils
import RxCocoa
import RxSwift

class ActivityDetailsCell: UITableViewCell, Dequeueable {

	private(set) var disposeBag = DisposeBag()

    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var detailsStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var athleteNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var spaceLabel1: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "."
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var spaceLabel2: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "."
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sportImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "soccer")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var averageSpeedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
        button.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.likeButtonAction(_:)), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var likesCountLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textAlignment = .right
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var athletesStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var athlete1ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "fan1")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var athlete2ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player3")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var athlete3ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player4")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var athlete4ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player2")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var athlete5ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player5")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var athlete6ImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "player1")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var likeButtonTap: ControlEvent<Void> {
        return likeButton.rx.tap
    }

    var activity: AthleteActivity!

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func configure(with activity: AthleteActivity) {
        titleLabel.text = activity.title
        if let firstName = activity.creator?.first_name, let lastName = activity.creator?.last_name {
            athleteNameLabel.text = firstName + lastName
		} else {
			athleteNameLabel.text = "-"
		}
        dateLabel.text = "Jan 9, 2022"
        averageSpeedLabel.text = "Avg Speed: \(activity.pace)"
		likesCountLabel.text = "\(activity.likes.count ?? 0)"

		guard let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

        if activity.isActivityLiked(userId: userId) {
            likeButton.tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up-selected"), for: .normal)
        } else {
            likeButton.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
        }
        self.activity = activity
    }
    
    // MARK: - UIButton Action
    @objc func likeButtonAction(_ button: UIButton) {
		guard let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

        if self.activity.isActivityLiked(userId: userId) {
//            self.activity.isActivityLiked = false
            likeButton.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
        } else {
//            self.activity.isActivityLiked = true
            likeButton.tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up-selected"), for: .normal)
        }
    }
}

// MARK: - Setup UI

private extension ActivityDetailsCell {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(titleLabel)
        
        detailsStackView.addArrangedSubview(athleteNameLabel)
        detailsStackView.addArrangedSubview(spaceLabel1)
        detailsStackView.addArrangedSubview(dateLabel)
        detailsStackView.addArrangedSubview(spaceLabel2)
        detailsStackView.addArrangedSubview(sportImageView)
        detailsStackView.addArrangedSubview(averageSpeedLabel)
        contentView.addSubview(detailsStackView)
        
        contentView.addSubview(likeButton)
        contentView.addSubview(likesCountLabel)
        
        athletesStackView.addArrangedSubview(athlete1ImageView)
        athletesStackView.addArrangedSubview(athlete2ImageView)
        athletesStackView.addArrangedSubview(athlete3ImageView)
        athletesStackView.addArrangedSubview(athlete4ImageView)
        athletesStackView.addArrangedSubview(athlete5ImageView)
        athletesStackView.addArrangedSubview(athlete6ImageView)
        contentView.addSubview(athletesStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 21),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            detailsStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            detailsStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 63),
            detailsStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -63),
            
            likeButton.centerYAnchor.constraint(equalTo: athletesStackView.centerYAnchor),
            likeButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 25),
            likeButton.widthAnchor.constraint(equalToConstant: 26),
            likeButton.heightAnchor.constraint(equalToConstant: 26),

            likesCountLabel.centerYAnchor.constraint(equalTo: athletesStackView.centerYAnchor),
            likesCountLabel.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 2),
            likesCountLabel.rightAnchor.constraint(equalTo: athletesStackView.leftAnchor, constant: -10),
                        
            athletesStackView.topAnchor.constraint(equalTo: detailsStackView.bottomAnchor, constant: 19),
            athletesStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            athletesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
        ])
    }
}


