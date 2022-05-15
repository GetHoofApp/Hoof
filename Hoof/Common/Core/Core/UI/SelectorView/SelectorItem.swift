//
//  SelectModel.swift
//  SignUp
//
//  Created by Sameh Mabrouk on 29/12/2021.
//

import UIKit
public class SelectorItem {

    public var title: String
    public var isSelected: Bool
    public var selectionType: ARSelectionType?
    public var width: CGFloat = 0.0

    public init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
        self.width = UILabel().sizeForLabel(text: title, font: ARSelectableCell.titleFont).width
    }
}
