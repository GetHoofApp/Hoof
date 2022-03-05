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
    func fetchAthleteActivties(userID: Int) -> Single<[Activity?]>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
}

public protocol HomeServicePerforming {
    func uploadActivity()
}

class HomeService: HomeServiceFetching {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func fetchAthleteActivties(userID: Int) -> Single<[Activity?]> {
        return client.fetch(query: PostsQuery(userId: userID))
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
                        
                        let distance = (($0?.distance ?? 0.0) / 1000).round(to: 2)
                        
                        var durationAsString = ""
                        if let duration = $0?.duration?.round(to: 2), duration > 0 {
                            let durationAsHour = duration / 3600
                            if durationAsHour > 1 {
                                durationAsString = "\(durationAsHour)"
                            }
                            
                            let durationAsMinutes = duration / 60
                            if durationAsMinutes > 0 {
                                if durationAsHour > 1 {
                                    durationAsString.append(contentsOf: ":")
                                }
                                durationAsString.append(contentsOf: "\(Int(durationAsMinutes))")
                            }

                            let durationAsSeconds = duration.truncatingRemainder(dividingBy: 60.0)
                            if durationAsSeconds > 0 {
                                if durationAsMinutes > 0 {
                                    durationAsString.append(contentsOf: ":")
                                }
                                durationAsString.append(contentsOf: "\(Int(durationAsSeconds))")
                            }
                        }
                        
                        var paceAsString = ""
                        if let pace = $0?.pace?.round(to: 2), pace > 0 {
                            let paceAsHour = pace / 3600
                            if paceAsHour > 1 {
                                paceAsString = "\(paceAsHour)"
                            }
                            
                            let paceAsMinutes = pace / 60
                            if paceAsMinutes > 0 {
                                if paceAsHour > 1 {
                                    paceAsString.append(contentsOf: ":")
                                }
                                paceAsString.append(contentsOf: "\(Int(paceAsMinutes))")
                            }

                            let paceAsSeconds = pace.truncatingRemainder(dividingBy: 60.0)
                            if paceAsSeconds > 0 {
                                if paceAsMinutes > 0 {
                                    paceAsString.append(contentsOf: ":")
                                }
                                paceAsString.append(contentsOf: "\(Int(paceAsSeconds))")

                            }
                        }

                        return Activity(id: $0?.id ?? "",
                                        title: $0?.title ?? "",
                                        description: $0?.description ?? "",
                                        createdAt: $0?.createdAt ?? Date(),
                                        creator: User(data: $0?.creator),
                                        coordinates: coordinates,
                                        duration: durationAsString,
                                        distance: "\(distance)" + " km",
                                        pace: paceAsString + " /km",
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
