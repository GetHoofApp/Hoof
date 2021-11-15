//
//  MapUseCase.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol MapInteractable {}

class MapUseCase: MapInteractable {

    private let service: MapServicePerforming
    
    init(service: MapServicePerforming) {
        self.service = service
    }
}
