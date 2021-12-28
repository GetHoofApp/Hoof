//
//  SignUpService.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol SignUpServicePerforming {
    func doSomething() -> Single<Bool>
}

class SignUpService: SignUpServicePerforming {
    
//    private let client: GraphQLClientProtocol
//
//    public init(client: GraphQLClientProtocol) {
//        self.client = client
//    }
    
    
    func doSomething() -> Single<Bool> {
        return .just(true)
    }
}
