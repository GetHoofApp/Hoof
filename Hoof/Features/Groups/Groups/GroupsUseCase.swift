//
//  GroupsUseCase.swift
//  Groups
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift

public protocol GroupsInteractable {}

class GroupsUseCase: GroupsInteractable {

    private let service: GroupsServicePerforming
    
    init(service: GroupsServicePerforming) {
        self.service = service
    }
}
