//
//  CreateProfileUseCase.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol CreateProfileInteractable {
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<Bool>
}

class CreateProfileUseCase: CreateProfileInteractable {
    
    private let service: CreateProfileServicePerforming
    
    init(service: CreateProfileServicePerforming) {
        self.service = service
    }
    
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<Bool> {
        service.createProfile(firstName: firstName, lastName: lastName, email: email, password: password, gender: gender)
    }
}
