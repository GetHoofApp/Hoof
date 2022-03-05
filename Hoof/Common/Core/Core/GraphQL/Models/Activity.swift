//
//  ActivityItem.swift
//  Home
//
//  Created by Sameh Mabrouk on 23/11/2021.
//

import Foundation
import UIKit
import CodableGeoJSON

public enum ActivityLikabilityStatus {
    case youGaveALike
    case youAndOneOthersGaveALike
    case youAndXOthersGaveALike
    case beTheFirstToGiveALike
    case oneGaveLikes
    case twoGaveLikes
    case xGaveLikes
    case unkown
}

public class Activity {
    
    public let id: String
    public let title: String
    public let description: String
    public let createdAt: Date
    public let creator: User?
    public let coordinates: MultiLineStringGeometry.Coordinates
    public var duration: String
    public var distance: String
    public var pace: String
    public let activityImage: UIImage
    public var likes: [Like]?
    public var comments: [Comment]?
    public var isActivityLiked = false
    public var activityLikabilityStatus: ActivityLikabilityStatus
    
    public init(id: String, title: String, description: String, createdAt: Date, creator: User?, coordinates: MultiLineStringGeometry.Coordinates, duration: String, distance: String, pace: String, activityImage: UIImage, likes: [Like]?, comments: [Comment]?, isActivityLiked: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.creator = creator
        self.coordinates = coordinates
        self.duration = duration
        self.distance = distance
        self.pace = pace
        self.activityImage = activityImage
        self.likes = likes
        self.comments = comments
        self.isActivityLiked = isActivityLiked
        
        if isActivityLiked && likes?.count == 1 {
            self.activityLikabilityStatus = .youGaveALike
        } else if !isActivityLiked && likes?.count == 1 {
            self.activityLikabilityStatus = .oneGaveLikes
        } else if isActivityLiked && likes?.count == 2 {
            self.activityLikabilityStatus = .youAndOneOthersGaveALike
        } else if !isActivityLiked && likes?.count == 2 {
            self.activityLikabilityStatus = .twoGaveLikes
        } else if isActivityLiked && likes?.count ?? 0 > 2 {
            self.activityLikabilityStatus = .youAndXOthersGaveALike
        } else if !isActivityLiked && likes?.count ?? 0 > 0 {
            self.activityLikabilityStatus = .xGaveLikes
        } else if !isActivityLiked && likes?.count == 0 {
            self.activityLikabilityStatus = .beTheFirstToGiveALike
        } else {
            self.activityLikabilityStatus = .unkown
        }
    }
}

public struct Like {
    
    public let id: String
    public let creator: User?
    
    public init?(data: PostsQuery.Data.Post.Like?) {
        guard let data = data else { return nil }
        
        self.id = data.id
        if let creator = data.creator {
            self.creator = User(data: creator)
        } else {
            creator = nil
        }
    }
    
    public init(id: String, creator: User) {
        self.id = id
        self.creator = creator
    }
}

public class User {
    
    public let id: String
    public let firstName: String
    public let lastName: String
    public let photoURL: String
    public var isAthleteFollowed = false

    public init(data: PostsQuery.Data.Post.Like.Creator) {
        self.id = data.id
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.photoURL = data.profileImage ?? ""
    }
    
    public init?(data: PostsQuery.Data.Post.Creator?) {
        guard let data = data else { return nil }

        self.id = data.id
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.photoURL = data.profileImage ?? ""
    }
    
    public init?(data: SuggestedAthletesQuery.Data.AthletesToFollow?) {
        guard let data = data else { return nil }

        self.id = data.id
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.photoURL = data.profileImage ?? ""
    }

    public init?(data: SearchUsersQuery.Data.SearchUser?) {
        guard let data = data else { return nil }

        self.id = data.id
        self.firstName = data.firstName
        self.lastName = data.lastName
        self.photoURL = data.profileImage ?? ""
    }
    
    public init(id: String, firstName: String, lastName: String, photoURL: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.photoURL = photoURL
    }
}

public struct Comment {
    
    public let id: String
    public let message: String
    
    public init?(data: PostsQuery.Data.Post.Comment?) {
        guard let data = data else { return nil }
        
        self.id = data.id
        self.message = data.message
    }
    
    public init(id: String, message: String) {
        self.id = id
        self.message = message
    }
}
