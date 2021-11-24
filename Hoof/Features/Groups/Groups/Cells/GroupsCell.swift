//
//  GroupsCell.swift
//  Groups
//
//  Created by Sameh Mabrouk on 19/11/2021.
//

import UIKit
import Core

class GroupsCell: UITableViewCell, Dequeueable {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Groups"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var groupsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "5"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
//        layout.itemSize = CGSize(width: 102, height: 127)
                
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.register(GroupCollectionViewCell.self, forCellWithReuseIdentifier: "GroupCollectionViewCell")
        collectionView.backgroundColor = .white
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    lazy private(set) var flowLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
//        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
//        flowLayout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        flowLayout.itemSize = CGSize(width: 105, height: 160)

        return flowLayout
    }()
    
    let groups: [(image: UIImage, backgroundColor: UIColor, groupName: String)] = [( #imageLiteral(resourceName: "soccer-ball").withTintColor(.white), UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0), "Collage Soccer"), ( #imageLiteral(resourceName: "soccer-shoe"), UIColor(red: 230/255, green: 52/255, blue: 103/255, alpha: 1.0),"Weekend Soccer"), ( #imageLiteral(resourceName: "player"), UIColor(red: 194/255, green: 143/255, blue: 239/255, alpha: 1.0),"Terrible Football")]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
}

// MARK: - Setup UI

private extension GroupsCell {
    
    func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        addSubview(titleLabel)
        addSubview(groupsCountLabel)
        addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16),
            titleLabel.widthAnchor.constraint(equalToConstant: 60),
            titleLabel.heightAnchor.constraint(equalToConstant: 22),
//            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            
            groupsCountLabel.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            groupsCountLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -28),
//            groupsCountLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            groupsCountLabel.heightAnchor.constraint(equalToConstant: 22),
            
            collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 40),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0)
        ])
    }
}

// MARK: - UICollectionViewDataSource

extension GroupsCell: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        3
    }
        
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GroupCollectionViewCell", for: indexPath) as! GroupCollectionViewCell
        let group = groups[indexPath.row]
        cell.setup(image: group.image, backgroundColor: group.backgroundColor, groupName: group.groupName)
        return cell
    }
}

// MARK: - UICollectionViewDelegate

extension GroupsCell: UICollectionViewDelegate {
    
}


