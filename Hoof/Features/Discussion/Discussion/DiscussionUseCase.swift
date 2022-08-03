//
//  DiscussionUseCase.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol DiscussionInteractable {
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool>
	func commentOnPost(activityUserID: String, userId: String, activityId: String, comment: String) -> Single<Bool>
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?>
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool>
}

class DiscussionUseCase: DiscussionInteractable {

    private let service: DiscussionServicePerforming
    
    init(service: DiscussionServicePerforming) {
        self.service = service
    }

	func commentOnPost(activityUserID: String, userId: String, activityId: String, comment: String) -> Single<Bool> {
		service.commentOnPost(activityUserID: activityUserID, userId: userId, activityId: activityId, comment: comment)
	}
	
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool> {
        service.commentOnPost(userID: userID, postID: postID, message: message)
    }
    
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?> {
		service.likePost(postUserID: postUserID, userId: userId, postID: postID)
	}

	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool> {
		service.unlikePost(userID: userID, postID: postID, likeId: likeId)
	}
}
