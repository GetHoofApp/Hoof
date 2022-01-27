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
//    func signUp(firstName: String, lastName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool>
}

class SignUpService: SignUpServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }    
    
    func doSomething() -> Single<Bool> {
        return .just(true)
    }
    
//    func signUp(firstName: String, lastName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) -> Single<Bool> {
//        return client.perform(mutation: CreateUserMutation(firstName: firstName, lastName: lastName, password: password, email: email, gender: gender, bio: bio, favoritePosition: favoritePosition, foot: foot, preferedNumber: preferedNumber)).map {
//            $0.createUser?.id != nil
//        }.asSingle()
//    }
}
