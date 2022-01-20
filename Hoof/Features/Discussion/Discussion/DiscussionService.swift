//
//  DiscussionService.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol DiscussionServicePerforming {
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
}

class DiscussionService: DiscussionServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool> {
        return client.perform(mutation: CommentOnPostMutation(userId: userID, postId: postID, message: message))
            .map { $0.commentOnPost?.success != nil }
            .asSingle()
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
