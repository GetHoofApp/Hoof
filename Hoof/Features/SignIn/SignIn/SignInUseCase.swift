//
//  SignInUseCase.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol SignInInteractable {
	func signIn(email: String, password: String) -> Single<String?>
}

class SignInUseCase: SignInInteractable {

    private let service: SignInServicePerforming
    
    init(service: SignInServicePerforming) {
        self.service = service
    }
    
	func signIn(email: String, password: String) -> Single<String?> {
		service.signIn(email: email, password: password)
	}
}
