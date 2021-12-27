//
//  WelcomeUseCase.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol WelcomeInteractable {
    func doSomething() -> Single<Bool>
}

class WelcomeUseCase: WelcomeInteractable {

    private let service: WelcomeServicePerforming
    
    init(service: WelcomeServicePerforming) {
        self.service = service
    }
    
    func doSomething() -> Single<Bool> {
        service.doSomething()
    }
}
