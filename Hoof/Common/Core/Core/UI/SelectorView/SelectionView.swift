//
//  SelectorView.swift
//  SignUp
//
//  Created by Sameh Mabrouk on 29/12/2021.
//

import UIKit

// CollectionView layout options
public struct ARCollectionLayoutDefaults {

    public let sectionInset: UIEdgeInsets
    public let lineSpacing: CGFloat
    public let interitemSpacing: CGFloat
    public let scrollDirection : UICollectionView.ScrollDirection

    public init(sectionInset: UIEdgeInsets = .zero,
                lineSpacing: CGFloat = SelectionView.DEFAULT_LINE_SPACING,
                interitemSpacing: CGFloat = SelectionView.DEFAULT_INTERITEM_SPACING,
                scrollDirection: UICollectionView.ScrollDirection = .vertical) {

        self.sectionInset = sectionInset
        self.lineSpacing = lineSpacing
        self.interitemSpacing = interitemSpacing
        self.scrollDirection = scrollDirection
    }
}

// CollectionView cell defaults
public struct ARCellDesignDefaults {

    public var selectedButtonColor : UIColor = .black
    public var defaultButtonColor : UIColor = .black
    public var selectedTitleColor : UIColor = .black
    public var defaultTitleColor : UIColor = .black
    public var selectedCellBGColor : UIColor = .white
    public var defaultCellBGColor : UIColor = .white
    public var rowHeight : CGFloat = 35
    public var isShowButton : Bool = true
    public var cornerRadius : CGFloat = 0
}

public protocol SelectionViewDelegate: AnyObject {
    func selectionMaxLimitReached( _ selectionView: SelectionView)
    func didSelectItem(_ selectItem: SelectorItem)
}

public final class SelectionView: UIView {

    // MARK: - Declared Variables
    public static let DEFAULT_LINE_SPACING: CGFloat = 0
    public static let DEFAULT_INTERITEM_SPACING : CGFloat = 0
    public weak var delegate: SelectionViewDelegate?

    private var reseource: (cell: ARSelectableCell?, identifier: String)?
    var cellDesignDefaults = ARCellDesignDefaults()
    lazy var tagLayout = FlowLayout()
    var maxSelectCount : Int?

    var options: ARCollectionLayoutDefaults = ARCollectionLayoutDefaults() {
        didSet{
            tagLayout.sectionInset = self.options.sectionInset
            tagLayout.minimumInteritemSpacing = options.interitemSpacing
            tagLayout.minimumLineSpacing = options.lineSpacing
            tagLayout.scrollDirection = options.scrollDirection
            if selectionType == .tags && options.scrollDirection != .horizontal {
                tagLayout.align = self.alignment == .right ? .right : .left
            }
            else {
                tagLayout.align = .none
            }
            self.collectionView.collectionViewLayout = tagLayout
            self.collectionView.reloadData()
        }
    }

    var alignment: ARSelectionAlignment? = .left {
        didSet {
            if selectionType == .tags && options.scrollDirection != .horizontal {
                tagLayout.align = self.alignment == .right ? .right : .left
            }
            else {
                tagLayout.align = .none
            }
            self.collectionView.reloadData()
        }
    }

    public var selectionType : ARSelectionType? {
        didSet {

            if selectionType == .tags && options.scrollDirection != .horizontal {
                tagLayout.align = self.alignment == .right ? .right : .left
            }
            else {
                tagLayout.align = .none
            }
            self.collectionView.collectionViewLayout = tagLayout
            self.items.forEach { $0.selectionType = self.selectionType }
            self.collectionView.reloadData()
        }
    }

    fileprivate lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect(), collectionViewLayout: UICollectionViewFlowLayout())
        cv.showsHorizontalScrollIndicator = false
        cv.showsVerticalScrollIndicator = false
        cv.bounces = false
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(ARSelectableCell.self, forCellWithReuseIdentifier: String(describing: ARSelectableCell.self))
        return cv
    }()

    public var items: [SelectorItem] = [] {
        didSet {
            self.items.forEach { $0.selectionType = self.selectionType }
            self.collectionView.reloadData()
            self.layoutIfNeeded()
        }
    }

    // MARK: - Init Methods
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.addViews()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.addViews()
        fatalError("init(coder:) has not been implemented")
    }

    fileprivate func addViews() {
        self.setupCollectionView()
    }

    // MARK: - Hepler Methods
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self

        self.reseource = (cell: ARSelectableCell(), String(describing: ARSelectableCell.self))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([collectionView.topAnchor.constraint(equalTo: topAnchor),
                                     collectionView.leftAnchor.constraint(equalTo: leftAnchor),
                                     collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
                                     collectionView.rightAnchor.constraint(equalTo: rightAnchor)])
    }

    fileprivate func updateSelection(_ selectItem: SelectorItem) {
        let status = selectItem.isSelected
        if self.selectionType == .radio {
            self.items.filter { $0.isSelected == true }.forEach { ($0).isSelected = false }
            selectItem.isSelected = !status
            collectionView.reloadData()
            delegate?.didSelectItem(selectItem)
        }
        else {
            if let maxCount = self.maxSelectCount, !selectItem.isSelected {
                let count = self.items.filter { $0.isSelected == true }.count
                if count < maxCount {
                    selectItem.isSelected.toggle()
                    collectionView.reloadData()
                }
                else {
                    self.delegate?.selectionMaxLimitReached(self)
                }
            }
            else{
                selectItem.isSelected.toggle()
                collectionView.reloadData()
            }
        }
    }
}

// MARK: - UICollectionView Delegate & DataSource
extension SelectionView: UICollectionViewDelegate, UICollectionViewDataSource {

    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueCell(ARSelectableCell.self, indexpath: indexPath) {

            cell.delegate = self
            cell.alignment = alignment ?? .left
            cell.configeCell(items[indexPath.row], designOptions: cellDesignDefaults)
            cell.layoutIfNeeded()
            return cell
        }
        return UICollectionViewCell()
    }

    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        updateSelection(items[indexPath.row])
    }
}

//MARK:- UICollectionViewDelegateFlowLayout
extension SelectionView: UICollectionViewDelegateFlowLayout {

    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if self.selectionType == .tags {
            guard let cell = reseource?.cell else { return .zero }
            cell.configeCell(items[indexPath.row], designOptions: cellDesignDefaults)
            let size = cell.fittingSize
            return CGSize(width: size.width, height: cellDesignDefaults.rowHeight)
        }
        else {
            if options.scrollDirection == .horizontal {
                return CGSize(width: items[indexPath.row].width, height: cellDesignDefaults.rowHeight)
            }
            else {
                return CGSize(width: frame.width, height: cellDesignDefaults.rowHeight)
            }
        }
    }
}

//MARK:- ARSelectionDelegate
extension SelectionView: SelectionDelegate {

    func didSelectItem(_ selectItem: SelectorItem) {
        updateSelection(selectItem)
    }
}
