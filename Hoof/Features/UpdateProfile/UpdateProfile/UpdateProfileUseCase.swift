//
//  UpdateProfileUseCase.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol UpdateProfileInteractable {
    func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage, userID: String) -> Single<String>
}

class UpdateProfileUseCase: UpdateProfileInteractable {

    private let service: UpdateProfileServicePerforming
    
    init(service: UpdateProfileServicePerforming) {
        self.service = service
    }
    
    func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage, userID: String) -> Single<String> {
        return Single.just("")
    }
}
