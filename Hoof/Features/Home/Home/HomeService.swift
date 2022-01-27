//
//  HomeService.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import CodableGeoJSON

public protocol HomeServiceFetching {
    func fetchAthleteActivties() -> Single<[Activity?]>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
}

class HomeService: HomeServiceFetching {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func fetchAthleteActivties() -> Single<[Activity?]> {
        return client.fetch(query: PostsQuery())
            .map {
                $0.posts?.compactMap {
                    guard case .geometry(let geometry, _) = $0?.coordinates else {
                        return nil
                    }
                    
                    switch geometry {
                    case .multiLineString(let coordinates):
                        let foundUserLike = $0?.likes.first(where: { $0.creator?.id == "7" }) != nil
                        let likes = $0?.likes.compactMap { Like(data: $0) }
                        let comments = $0?.comments.compactMap { Comment(data: $0) }
                        
                        return Activity(id: $0?.id ?? "",
                                        title: $0?.title ?? "",
                                        description: $0?.description ?? "",
                                        createdAt: $0?.createdAt ?? Date(),
                                        creator: User(data: $0?.creator),
                                        coordinates: coordinates,
                                        distance: "30 KM", pace: "5 /Km",
                                        activityImage: #imageLiteral(resourceName: "player5"),
                                        likes: likes,
                                        comments: comments,
                                        isActivityLiked: foundUserLike)
                        
                    default:
                        return nil
                    }
                    
                } ?? []
            }.asSingle()
    }
    
    func likePost(userID: String, postID: String) -> Single<Bool> {
        return client.perform(mutation: LikePostMutation(userId: userID, postId: postID))
            .map {
                $0.likePost?.like?.id != nil
            }
            .asSingle()
    }
    
    func unlikePost(userID: String, postID: String) -> Single<Bool> {
        return client.perform(mutation: UnlikePostMutation(userId: userID, postId: postID))
            .map { $0.unlikePost?.success != nil }
            .asSingle()
    }
}
