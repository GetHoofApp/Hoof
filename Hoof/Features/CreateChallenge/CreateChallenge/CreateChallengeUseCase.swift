//
//  CreateChallengeUseCase.swift
//  CreateChallenge
//
//  Created Sameh Mabrouk on 24/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol CreateChallengeInteractable {
}

class CreateChallengeUseCase: CreateChallengeInteractable {

    private let service: CreateChallengeServicePerforming
    
    init(service: CreateChallengeServicePerforming) {
        self.service = service
    }
}
