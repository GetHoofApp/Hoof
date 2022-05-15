//
//  UpdateProfileService.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core

public protocol UpdateProfileServicePerforming {
    func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage, userID: String) -> Single<String>
}

class UpdateProfileService: UpdateProfileServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage, userID: String) -> Single<String> {
        return Single.just("")
    }
}
