//
//  GettingStartedViewModel.swift
//  GettingStarted
//
//  Created Sameh Mabrouk on 05/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol GettingStartedViewModellable: ViewModellable {
    var inputs: GettingStartedViewModelInputs { get }
    var outputs: GettingStartedViewModelOutputs { get }
}

struct GettingStartedViewModelInputs {}

struct GettingStartedViewModelOutputs {}

class GettingStartedViewModel: GettingStartedViewModellable {

    let disposeBag = DisposeBag()
    let inputs = GettingStartedViewModelInputs()
    let outputs = GettingStartedViewModelOutputs()
    var useCase: GettingStartedInteractable

    init(useCase: GettingStartedInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension GettingStartedViewModel {

    func setupObservables() {}
}
