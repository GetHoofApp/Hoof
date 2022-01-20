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
    func fetchAthleteActivties() -> Single<[Activity?]>
    func likePost(userID: String, postID: String) -> Single<Bool>
    func unlikePost(userID: String, postID: String) -> Single<Bool>
}

class HomeUseCase: HomeInteractable {

    private let service: HomeServiceFetching
    
    init(service: HomeServiceFetching) {
        self.service = service
    }
    
    func fetchAthleteActivties() -> Single<[Activity?]> {
        service.fetchAthleteActivties()
    }
    
    func likePost(userID: String, postID: String) -> Single<Bool> {
        service.likePost(userID: userID, postID: postID)
    }
    
    func unlikePost(userID: String, postID: String) -> Single<Bool> {
        service.unlikePost(userID: userID, postID: postID)
    }
}
