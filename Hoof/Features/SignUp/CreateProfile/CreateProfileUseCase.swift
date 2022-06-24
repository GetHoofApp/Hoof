//
//  CreateProfileUseCase.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol CreateProfileInteractable {
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String>
	func createUserProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String?>
}

class CreateProfileUseCase: CreateProfileInteractable {
    
    private let service: CreateProfileServicePerforming
    
    init(service: CreateProfileServicePerforming) {
        self.service = service
    }
    
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String> {
        service.createProfile(firstName: firstName, lastName: lastName, email: email, password: password, gender: gender)
    }

	func createUserProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String?> {
		service.createUserProfile(firstName: firstName, lastName: lastName, email: email, password: password, gender: gender)
	}
}
