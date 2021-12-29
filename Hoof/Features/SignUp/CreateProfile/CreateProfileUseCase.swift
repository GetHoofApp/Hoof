//
//  CreateProfileUseCase.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol CreateProfileInteractable {
    func createProfile(userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool>
}

class CreateProfileUseCase: CreateProfileInteractable {
    
    private let service: CreateProfileServicePerforming
    
    init(service: CreateProfileServicePerforming) {
        self.service = service
    }
    
    func createProfile(userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool> {
        service.createProfile(userName: userName, email: email, password: password, gender: gender, bio: bio, favoritePosition: favoritePosition, foot: foot, preferedNumber: preferedNumber)
    }
}
