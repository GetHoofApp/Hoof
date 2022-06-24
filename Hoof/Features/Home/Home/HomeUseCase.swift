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
    func fetchAthleteActivties(userID: String) -> Single<[AthleteActivity?]>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
	func helloWorld()
}

class HomeUseCase: HomeInteractable {

    private let service: HomeServiceFetching
    
    init(service: HomeServiceFetching) {
        self.service = service
    }
    
    func fetchAthleteActivties(userID: String) -> Single<[AthleteActivity?]> {
//        service.fetchAthleteActivties(userID: userID)
		service.fetchAthelteActivitiesTimeline(userID: userID)
    }
    
    func likePost(userID: String, postID: String) -> Single<Bool> {
        service.likePost(userID: userID, postID: postID)
    }
    
    func unlikePost(userID: String, postID: String) -> Single<Bool> {
        service.unlikePost(userID: userID, postID: postID)
    }

	func helloWorld() {
		service.helloWorld()
	}
}
