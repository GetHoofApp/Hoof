//
//  ActivitiesService.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol ActivitiesServicePerforming {
    func doSomething() -> Single<Bool>
}

class ActivitiesService: ActivitiesServicePerforming {
    
    func doSomething() -> Single<Bool> {
        return .just(true)
    }
}
