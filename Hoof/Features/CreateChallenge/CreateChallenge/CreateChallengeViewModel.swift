//
//  CreateChallengeViewModel.swift
//  CreateChallenge
//
//  Created Sameh Mabrouk on 24/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol CreateChallengeViewModellable: ViewModellable {
    var inputs: CreateChallengeViewModelInputs { get }
    var outputs: CreateChallengeViewModelOutputs { get }
}

struct CreateChallengeViewModelInputs {}

struct CreateChallengeViewModelOutputs {}

class CreateChallengeViewModel: CreateChallengeViewModellable {

    let disposeBag = DisposeBag()
    let inputs = CreateChallengeViewModelInputs()
    let outputs = CreateChallengeViewModelOutputs()
    var useCase: CreateChallengeInteractable

    init(useCase: CreateChallengeInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension CreateChallengeViewModel {

    func setupObservables() {}
}
