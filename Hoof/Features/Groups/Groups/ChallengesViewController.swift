//
//  ChallengesViewController.swift
//  Groups
//
//  Created by Sameh Mabrouk on 22/11/2021.
//

import UIKit

class ChallengesViewController: UIViewController {
    
    // MARK: - Properties
    
    static let sectionHeaderElementKind = "section-header-element-kind"
    
    private lazy var createChallengeView: CreateChallengeView = {
        let view = CreateChallengeView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: generateLayout())
        collectionView.backgroundColor = UIColor(red: 243/255, green: 246/255, blue: 250/255, alpha: 1.0)
        collectionView.delegate = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(ChallengeCell.self, forCellWithReuseIdentifier: ChallengeCell.reuseIdentifer)
        collectionView.register(
            ChallengesSectionHeaderView.self,
            forSupplementaryViewOfKind: ChallengesViewController.sectionHeaderElementKind,
            withReuseIdentifier: ChallengesSectionHeaderView.reuseIdentifier)
        return collectionView
    }()
    
    enum Section {
        case challenges
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, ChallengeItem>!
    
    let challenges: [ChallengeItem] = [ChallengeItem(image:  #imageLiteral(resourceName: "soccer-ball"), title: "November Fastest Sprint Challenge", details: "Run a fast sprint during a football match", date: "Nov 20 to Nov 30, 2021", backgroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)),
                                       ChallengeItem(image:  #imageLiteral(resourceName: "soccer-ball"), title: "November Distance Challenge", details: "Run a distance of 200 kilometers", date: "Nov 20 to Nov 30, 2021", backgroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)),
                                       ChallengeItem(image:  #imageLiteral(resourceName: "soccer-shoe"), title: "November Top Scorer Challenge", details: "Score a total of 10 goals ", date: "Nov 20 to Nov 30, 2021", backgroundColor: UIColor(red: 230/255, green: 52/255, blue: 103/255, alpha: 1.0)),
                                       ChallengeItem(image:  #imageLiteral(resourceName: "player"), title: "November Best Stricker Position Challenge", details: "Best looking heatmap for a stricker position", date: "Nov 20 to Nov 30, 2021", backgroundColor: UIColor(red: 194/255, green: 143/255, blue: 239/255, alpha: 1.0))]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configureDataSource()
    }
    
    func generateLayout() -> UICollectionViewLayout {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        
        let fullPhotoItem = NSCollectionLayoutItem(layoutSize: itemSize)
        fullPhotoItem.contentInsets = NSDirectionalEdgeInsets(
            top: 4,
            leading: 4,
            bottom: 4,
            trailing: 4)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1/3))
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: fullPhotoItem,
            count: 2
        )
        
        let headerSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(100))
        let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: headerSize,
            elementKind: ChallengesViewController.sectionHeaderElementKind,
            alignment: .top)
        
        let section = NSCollectionLayoutSection(group: group)
        section.boundarySupplementaryItems = [sectionHeader]
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }
    
    func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource
        <Section, ChallengeItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, challengeItem: ChallengeItem) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: ChallengeCell.reuseIdentifer,
                    for: indexPath) as? ChallengeCell else { fatalError("Could not create new cell") }
            //        let challenge = self.challenges[indexPath.row]
            cell.configure(challengeTitle: challengeItem.title, challengeDescription: challengeItem.details, challengeDate: challengeItem.date, image: challengeItem.image, backgroundColor: challengeItem.backgroundColor)
            return cell
        }
        
        dataSource.supplementaryViewProvider = { (
            collectionView: UICollectionView,
            kind: String,
            indexPath: IndexPath)
            -> UICollectionReusableView? in
            
            guard let supplementaryView = collectionView.dequeueReusableSupplementaryView(
                    ofKind: kind,
                    withReuseIdentifier: ChallengesSectionHeaderView.reuseIdentifier,
                    for: indexPath) as? ChallengesSectionHeaderView else {
                fatalError("Cannot create header view")
            }
            
            //          supplementaryView.label.text = Section.allCases[indexPath.section].rawValue
            return supplementaryView
        }
        
        let snapshot = snapshotForCurrentState()
        dataSource.apply(snapshot, animatingDifferences: false)
    }
    
    func snapshotForCurrentState() -> NSDiffableDataSourceSnapshot<Section, ChallengeItem> {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ChallengeItem>()
        snapshot.appendSections([Section.challenges])
        let items = challenges
        snapshot.appendItems(items)
        return snapshot
    }
}


// MARK: - Setup UI

private extension ChallengesViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        setupSubviews()
        setupConstraints()
    }
    
    func setupSubviews() {
        //        view.addSubview(createChallengeView)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            //            createChallengeView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            //            createChallengeView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            //            createChallengeView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            //            createChallengeView.heightAnchor.constraint(equalToConstant: 52),
            //
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: -91),
            collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -220),
        ])
    }
}

extension ChallengesViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    }
}



