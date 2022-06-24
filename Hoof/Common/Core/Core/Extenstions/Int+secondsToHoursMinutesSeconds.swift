//
//  Int+secondsToHoursMinutesSeconds.swift
//  Core
//
//  Created by Sameh Mabrouk on 23/06/2022.
//

extension Int {

	public func secondsToHoursMinutesSeconds() -> (h: Int, m: Int, s: Int) {
		return (self / 3600, (self % 3600) / 60, (self % 3600) % 60)
	}
}
