//
//  GettingStartedService.swift
//  GettingStarted
//
//  Created Sameh Mabrouk on 05/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol GettingStartedServicePerforming {
    func doSomething() -> Single<Bool>
}

class GettingStartedService: GettingStartedServicePerforming {
    
    private let client: GraphQLClientProtocol
    private let serviceErrorListener: ServiceErrorListener
    
    public init(client: GraphQLClientProtocol, serviceErrorListener: ServiceErrorListener) {
        self.client = client
        self.serviceErrorListener = serviceErrorListener
    }
    
    
    func doSomething() -> Single<Bool> {
        return .just(true)
    }
}

private extension GettingStartedService {
    func notifyError(_ error: Error) {
        serviceErrorListener.notifyError(errorMessage: error.localizedDescription, error: error)
    }
}
