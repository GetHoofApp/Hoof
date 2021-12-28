//
//  SignUpUseCase.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol SignUpInteractable {
    func doSomething() -> Single<Bool>
}

class SignUpUseCase: SignUpInteractable {

    private let service: SignUpServicePerforming
    
    init(service: SignUpServicePerforming) {
        self.service = service
    }
    
    func doSomething() -> Single<Bool> {
        service.doSomething()
    }
}
