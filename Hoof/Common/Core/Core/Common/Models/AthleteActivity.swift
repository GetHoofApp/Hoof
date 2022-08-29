//
//  Activity.swift
//  Core
//
//  Created by Sameh Mabrouk on 22/06/2022.
//

import FirebaseFirestore

public struct Athlete: Codable {

	public let user_id: String
	public let first_name: String
	public let last_name: String
	public let imageUrl: String?
	public let gender: String?
	public var followersCount: Int?
	public var followingCount: Int?

	public init(user_id: String, first_name: String, last_name: String, imageUrl: String?, gender: String?, followersCount: Int, followingCount: Int) {
		self.user_id = user_id
		self.first_name = first_name
		self.last_name = last_name
		self.imageUrl = imageUrl
		self.gender = gender
		self.followersCount = followersCount
		self.followingCount = followingCount
	}

	public init?(data: [String: Any]?) {
		guard let userId = data?["user_id"] as? String,
			  let firstName = data?["first_name"] as? String,
			  let lastName = data?["last_name"] as? String,
			  let gender = data?["gender"] as? String,
			  let imageUrl = data?["imageUrl"] as? String else { return nil }
		self.user_id = userId
		self.first_name = firstName
		self.last_name = lastName
		self.gender = gender
		self.imageUrl = imageUrl
//		self.followingCount = 0
//		self.followingCount = 0
	}
}

public struct AthleteActivity: Codable {

	public let id: String
	public let duration: Double?
	public let title: String
	public let description: String
	public let pace: Int
	public let distance: Float
	public let user_id: String
	public let creator: Athlete?
	public var comments: [AthleteActivityComment]
	public var likes: [AthleteActivityLike]
	public var coordinates: [HoofGeoPoint]?
	public var date: String?

	public var activityLikabilityStatus: ActivityLikabilityStatus {
		guard let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return .unkown }

		if isActivityLiked(userId: userId) && likes.count == 1 {
			return .youGaveALike
		} else if !isActivityLiked(userId: userId) && likes.count == 1 {
			return .oneGaveLikes
		} else if isActivityLiked(userId: userId) && likes.count == 2 {
			return .youAndOneOthersGaveALike
		} else if !isActivityLiked(userId: userId) && likes.count == 2 {
			return .twoGaveLikes
		} else if isActivityLiked(userId: userId) && likes.count > 2 {
			return .youAndXOthersGaveALike
		} else if !isActivityLiked(userId: userId) && likes.count > 0 {
			return .xGaveLikes
		} else if !isActivityLiked(userId: userId) && likes.count == 0 {
			return .beTheFirstToGiveALike
		} else {
			return .unkown
		}
	}

	private enum CodingKeys: String, CodingKey {
		case id, duration, title, description, pace, distance, user_id, comments, likes, coordinates, creator, date
	}

	public init(id: String, duration: Double?, title: String, description: String, pace: Int, distance: Float, user_id: String, comments: [AthleteActivityComment], likes: [AthleteActivityLike], coordinates: [HoofGeoPoint]?, creator: Athlete?, date: String?) {
		self.id = id
		self.duration = duration
		self.title = title
		self.description = description
		self.distance = distance
		self.pace = pace
		self.user_id = user_id
		self.comments = comments
		self.likes = likes
		self.coordinates = coordinates
		self.creator = creator
		self.date = date
	}
}

public struct HoofGeoPoint: Codable {

	public let latitude: Double
	public let longitude: Double

	init(latitude: Double, longitude: Double) {
		self.latitude = latitude
		self.longitude = longitude
	}
}

public struct AthleteActivityComment: Codable {

	public let id: String
	public let user_id: String
	public let text: String
	public let creator: Athlete?


	public init(id: String, user_id: String, text: String, creator: Athlete?) {
		self.id = id
		self.user_id = user_id
		self.text = text
		self.creator = creator
	}
}

public struct AthleteActivityLike: Codable {

	public var id: String
	public let creator: Athlete?

	public init(id: String, creator: Athlete?) {
		self.id = id
		self.creator = creator
	}
}

extension AthleteActivity {

//	public override var isActivityLiked: Bool {
//		return ((self.likes.first(where: {$0.user_id == ""})) != nil)
//	}

	public func isActivityLiked(userId: String) -> Bool {
		return ((self.likes.first(where: {$0.creator?.user_id == userId})) != nil)
	}

//	mutating public func updateActivityLikability(shouldLikeActivity: Bool, userId: String) {
//		if shouldLikeActivity {
//			likes.append(AthleteActivityLike(id: "", user_id: userId))
//		} else {
//			likes.removeAll { $0.creator?.user_id == userId }
//		}
//	}
}

