//
//  SelectModel.swift
//  SignUp
//
//  Created by Sameh Mabrouk on 29/12/2021.
//

import UIKit
public class SelectorItem {

    var title: String
    var isSelected: Bool
    var selectionType: ARSelectionType?
    var width: CGFloat = 0.0

    init(title: String, isSelected: Bool = false) {
        self.title = title
        self.isSelected = isSelected
        self.width = UILabel().sizeForLabel(text: title, font: ARSelectableCell.titleFont).width
    }
}
