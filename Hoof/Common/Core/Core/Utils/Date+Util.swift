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

	func getTimeOfDay() -> String {
		let hour = Calendar.current.component(.hour, from: self)

		switch hour {
		case 6..<12 : return NSLocalizedString("Morning", comment: "Morning")
		case 12 : return NSLocalizedString("Noon", comment: "Noon")
		case 13..<17 : return NSLocalizedString("Afternoon", comment: "Afternoon")
		case 17..<22 : return NSLocalizedString("Evening", comment: "Evening")
		default: return NSLocalizedString("Night", comment: "Night")
		}
	}
}
