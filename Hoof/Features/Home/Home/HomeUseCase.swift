//
//  HomeUseCase.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol HomeInteractable {
	func fetchAthleteActivties(userID: String, lastVisibleUserId: String, limit: Int) -> Single<[AthleteActivity?]>
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?>
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool>
	func helloWorld()
}

class HomeUseCase: HomeInteractable {

    private let service: HomeServiceFetching
    
    init(service: HomeServiceFetching) {
        self.service = service
    }
    
    func fetchAthleteActivties(userID: String, lastVisibleUserId: String, limit: Int) -> Single<[AthleteActivity?]> {
//        service.fetchAthleteActivties(userID: userID)
		service.fetchAthelteActivitiesTimeline(userID: userID, lastVisibleUserId: lastVisibleUserId, limit: limit)
    }

	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?> {
		service.likePost(postUserID: postUserID, userId: userId, postID: postID)
	}
    
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool> {
		service.unlikePost(userID: userID, postID: postID, likeId: likeId)
    }

	func helloWorld() {
		service.helloWorld()
	}
}
