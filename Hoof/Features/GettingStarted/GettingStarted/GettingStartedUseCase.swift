//
//  GettingStartedUseCase.swift
//  GettingStarted
//
//  Created Sameh Mabrouk on 05/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol GettingStartedInteractable {
    func doSomething() -> Single<Bool>
}

class GettingStartedUseCase: GettingStartedInteractable {

    private let service: GettingStartedServicePerforming
    
    init(service: GettingStartedServicePerforming) {
        self.service = service
    }
    
    func doSomething() -> Single<Bool> {
        service.doSomething()
    }
}
