//
//  DiscussionUseCase.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol DiscussionInteractable {
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
}

class DiscussionUseCase: DiscussionInteractable {

    private let service: DiscussionServicePerforming
    
    init(service: DiscussionServicePerforming) {
        self.service = service
    }
    
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool> {
        service.commentOnPost(userID: userID, postID: postID, message: message)
    }
    
    func likePost(userID: String, postID: String) -> Single<Bool> {
        service.likePost(userID: userID, postID: postID)
    }
    
    func unlikePost(userID: String, postID: String) -> Single<Bool> {
        service.unlikePost(userID: userID, postID: postID)
    }
}
