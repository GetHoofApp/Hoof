//
//  HomeUseCase.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

public protocol HomeInteractable {
}

class HomeUseCase: HomeInteractable {

    private let service: HomeServicePerforming
    
    init(service: HomeServicePerforming) {
        self.service = service
    }
}
