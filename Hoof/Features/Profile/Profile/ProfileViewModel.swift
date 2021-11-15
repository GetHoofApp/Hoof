//
//  ProfileViewModel.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol ProfileViewModellable: ViewModellable {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModelInputs {}

struct ProfileViewModelOutputs {}

class ProfileViewModel: ProfileViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ProfileViewModelInputs()
    let outputs = ProfileViewModelOutputs()
    var useCase: ProfileInteractable

    init(useCase: ProfileInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension ProfileViewModel {

    func setupObservables() {}
}
