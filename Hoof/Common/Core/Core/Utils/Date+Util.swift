//
//  Date+Util.swift
//  Core
//
//  Created by Sameh Mabrouk on 07/01/2022.
//

import Foundation

public extension Date {
    
    func toString(dateFormat format: HoofDateFormat) -> String {
        return toString(dateFormat: format.rawValue)
    }
    
    private func toString( dateFormat format: String ) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}
