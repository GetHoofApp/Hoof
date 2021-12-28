//
//  URL+Util.swift
//  Core
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

import Foundation

public extension URL {
    ///Pass a string without having to unwrap
    init(staticString string: String) {
        guard let url = URL(string: "\(string)") else {
            preconditionFailure("Invalid static URL string: \(string)")
        }
        
        self = url
    }
}
