//
//  Activity.swift
//  Core
//
//  Created by Sameh Mabrouk on 22/06/2022.
//

public struct AthleteActivity: Codable {

	public let duration: Int
	public let title: String
	public let description: String
	public let pace: Int
	public let distance: Float

	public init(duration: Int, title: String, description: String, pace: Int, distance: Float) {
		self.duration = duration
		self.title = title
		self.description = description
		self.distance = distance
		self.pace = pace
	}
}
