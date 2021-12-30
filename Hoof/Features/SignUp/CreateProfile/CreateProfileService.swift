//
//  CreateProfileService.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol CreateProfileServicePerforming {
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<Bool>
}

class CreateProfileService: CreateProfileServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<Bool> {
//        return client.perform(mutation: CreateUserMutation(username: userName, password: password, email: email, gender: gender)).map {
//            $0.createUser?.id != nil
//        }.asSingle()
        return Single.never()
    }
}
