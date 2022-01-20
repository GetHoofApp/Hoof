//
//  ActivityItem.swift
//  Home
//
//  Created by Sameh Mabrouk on 23/11/2021.
//

import Foundation
import UIKit
import CodableGeoJSON

public class Activity {
    
    public let id: String
    public let title: String
    public let description: String
    public let createdAt: Date
    public let coordinates: MultiLineStringGeometry.Coordinates
    
    public let userName: String
    public let userPhoto: UIImage
    
    public let distance: String
    public let pace: String
    public let activityImage: UIImage
    public let likes: [Like]?
    public var comments: [Comment]?
    public var isActivityLiked = false
    
    public init(id: String, title: String, description: String, createdAt: Date, coordinates: MultiLineStringGeometry.Coordinates, userName: String, userPhoto: UIImage, distance: String, pace: String, activityImage: UIImage, likes: [Like]?, comments: [Comment]?, isActivityLiked: Bool) {
        self.id = id
        self.title = title
        self.description = description
        self.createdAt = createdAt
        self.coordinates = coordinates
        self.userName = userName
        self.userPhoto = userPhoto
        self.distance = distance
        self.pace = pace
        self.activityImage = activityImage
        self.likes = likes
        self.comments = comments
        self.isActivityLiked = isActivityLiked
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
}

public struct User {
    
    public let id: String
    
    public init(data: PostsQuery.Data.Post.Like.Creator) {
        self.id = data.id
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
