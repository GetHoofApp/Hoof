//
//  ProfileUseCase.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

public protocol ProfileInteractable {
	func fetchAthleteProfile() -> Single<Athlete?>
}

class ProfileUseCase: ProfileInteractable {

    private let service: ProfileServicePerforming
    
    init(service: ProfileServicePerforming) {
        self.service = service
    }

	func fetchAthleteProfile() -> Single<Athlete?> {
		service.fetchAthleteProfile()
	}
}
