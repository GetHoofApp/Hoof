//
//  SignUpViewModel.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol SignUpViewModellable: ViewModellable {
    var inputs: SignUpViewModelInputs { get }
    var outputs: SignUpViewModelOutputs { get }
}

struct SignUpViewModelInputs {}

struct SignUpViewModelOutputs {}

class SignUpViewModel: SignUpViewModellable {

    let disposeBag = DisposeBag()
    let inputs = SignUpViewModelInputs()
    let outputs = SignUpViewModelOutputs()
    var useCase: SignUpInteractable

    init(useCase: SignUpInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension SignUpViewModel {

    func setupObservables() {}
}
