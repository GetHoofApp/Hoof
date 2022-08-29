//
//  ActivitiesUseCase.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol ActivitiesInteractable {
    func doSomething() -> Single<Bool>
}

class ActivitiesUseCase: ActivitiesInteractable {

    private let service: ActivitiesServicePerforming
    
    init(service: ActivitiesServicePerforming) {
        self.service = service
    }
    
    func doSomething() -> Single<Bool> {
        service.doSomething()
    }
}
