//
//  Double.swift
//  Core
//
//  Created by Sameh Mabrouk on 05/03/2022.
//

public extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}
