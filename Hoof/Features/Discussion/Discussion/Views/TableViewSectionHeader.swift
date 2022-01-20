//
//  TableViewSectionheader.swift
//  Home
//
//  Created by Sameh Mabrouk on 17/01/2022.
//

import UIKit

public class Separator: UIView {
    override public var intrinsicContentSize: CGSize {
        return CGSize(width: 0, height: 0.2)
    }
} 

class TableViewSectionHeader: UITableViewHeaderFooterView {
    
    private lazy var separatorView: Separator = {
        let separator = Separator(frame: .zero)
        separator.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        separator.translatesAutoresizingMaskIntoConstraints = false
        return separator
    }()

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Setup UI

private extension TableViewSectionHeader {
    
    func setupUI() {
        setupSubviews()
        setupConstraints()
        
        // Make the background of UITableViewHeaderFooterView transparent
        tintColor = .white
    }
    
    func setupSubviews() {
        addSubview(separatorView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            separatorView.leftAnchor.constraint(equalTo: leftAnchor, constant: 67),
            separatorView.rightAnchor.constraint(equalTo: rightAnchor),
            separatorView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
