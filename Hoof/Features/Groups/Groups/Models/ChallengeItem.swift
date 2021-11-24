//
//  ChallengeItem.swift
//  Groups
//
//  Created by Sameh Mabrouk on 22/11/2021.
//

import Foundation
import UIKit

class ChallengeItem: Hashable {
    
    let image: UIImage
    let title: String
    let details: String
    let date: String
    let backgroundColor: UIColor
    
    init(image: UIImage, title: String, details: String, date: String, backgroundColor: UIColor) {
        self.image = image
        self.title = title
        self.details = details
        self.date = date
        self.backgroundColor = backgroundColor
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(identifier)
    }
    
    static func == (lhs: ChallengeItem, rhs: ChallengeItem) -> Bool {
        return lhs.identifier == rhs.identifier
    }
    
    private let identifier = UUID()
}
