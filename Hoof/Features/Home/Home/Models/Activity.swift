//
//  ActivityItem.swift
//  Home
//
//  Created by Sameh Mabrouk on 23/11/2021.
//

import Foundation
import UIKit
import CodableGeoJSON
import Core

public class Activity {
    
    let id: String
    let title: String
    let description: String
    let createdAt: Date
    let coordinates: MultiLineStringGeometry.Coordinates
    
    let userName: String
    let userPhoto: UIImage
    
    let distance: String
    let pace: String
    let activityImage: UIImage
    let likes: [Like]?
    let comments: [Comment]?
    var isActivityLiked = false
    
    init(id: String, title: String, description: String, createdAt: Date, coordinates: MultiLineStringGeometry.Coordinates, userName: String, userPhoto: UIImage, distance: String, pace: String, activityImage: UIImage, likes: [Like]?, comments: [Comment]?, isActivityLiked: Bool) {
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
    
    let id: String
    let creator: User?
    
    init?(data: PostsQuery.Data.Post.Like?) {
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
    
    let id: String
    
    init(data: PostsQuery.Data.Post.Like.Creator) {
        self.id = data.id
    }
}

public struct Comment {
    
    let id: String
    let message: String
    
    init?(data: PostsQuery.Data.Post.Comment?) {
        guard let data = data else { return nil }
        
        self.id = data.id
        self.message = data.message
    }
}
