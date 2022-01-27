//
//  UIImageView+Utils.swift
//  Core
//
//  Created by Sameh Mabrouk on 21/01/2022.
//

import UIKit

public extension UIImageView {

    func makeRounded() {
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.cornerRadius = frame.height / 2
        clipsToBounds = true
    }
}
