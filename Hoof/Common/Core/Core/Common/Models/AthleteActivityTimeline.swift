//
//  AthleteActivityTimeline.swift
//  Core
//
//  Created by Sameh Mabrouk on 22/06/2022.
//

public struct AthleteActivityTimeline: Codable {

	public let activities: [AthleteActivity]

	public init(activities: [AthleteActivity]) {
		self.activities = activities
	}
}
