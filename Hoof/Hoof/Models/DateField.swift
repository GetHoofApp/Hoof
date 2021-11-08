//
//  DateField.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 02/11/2021.
//

import Foundation

/// To hold each date pattern type for `DateFieldTypeView`
struct DateField {
    
    /// Title/type of the pattern (e.g. Year / Second)
    var type: String
    
    /// Patterns of that falls under said type (e.g `YYYY` / `ss`)
    var patterns: [String]
    
    /// To facilitate explanation of said pattern, that falls under same type, if needed.
    ///
    /// Key of subtitle should be accessible in `patterns`
    var subtitles: [String: String]?
}
