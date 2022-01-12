//
//  String+Util.swift
//  Core
//
//  Created by Sameh Mabrouk on 06/01/2022.
//

public enum HoofDateFormat: String {
    case MMM_dd_yyyy = "MMM dd yyyy h:mm a"
    case yyyy_MM_dd_HH_mm_ss = "yyyy-MM-dd'T'HH:mm:ss.SSS"
}
//2022-01-05T14:30:43.836012
public extension String {
    
    func toDate(dateFormate formate: HoofDateFormat) -> Date? {
        toDate(dateFormat: formate.rawValue)
    }
    
    private func toDate(dateFormat format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.defaultDate = Calendar.current.startOfDay(for: Date())
        return dateFormatter.date(from: self)
    }
}
