//
//  WelcomeService.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
//import Apollo
import Core

public protocol WelcomeServicePerforming {
    func doSomething() -> Single<Bool>
}

class WelcomeService: WelcomeServicePerforming {
    
//    private let client: GraphQLClientProtocol
//
//    public init(client: GraphQLClientProtocol) {
//        self.client = client
//    }
    
    
    func doSomething() -> Single<Bool> {
        return .just(true)
    }
}
