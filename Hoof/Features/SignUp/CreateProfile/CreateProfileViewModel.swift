//
//  CreateProfileViewModel.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol CreateProfileViewModellable: ViewModellable {
    var inputs: CreateProfileViewModelInputs { get }
    var outputs: CreateProfileViewModelOutputs { get }
}

struct CreateProfileViewModelInputs {}

struct CreateProfileViewModelOutputs {}

class CreateProfileViewModel: CreateProfileViewModellable {

    let disposeBag = DisposeBag()
    let inputs = CreateProfileViewModelInputs()
    let outputs = CreateProfileViewModelOutputs()
    var useCase: CreateProfileInteractable

    init(useCase: CreateProfileInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension CreateProfileViewModel {

    func setupObservables() {}
}
