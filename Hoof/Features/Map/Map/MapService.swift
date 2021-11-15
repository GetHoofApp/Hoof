//
//  MapService.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol MapServicePerforming {
    func doSomething() -> Single<Bool>
}

class MapService: MapServicePerforming {
    
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

private extension MapService {
    func notifyError(_ error: Error) {
        serviceErrorListener.notifyError(errorMessage: error.localizedDescription, error: error)
    }
}
