//
//  ActivitiesViewModel.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol ActivitiesViewModellable: ViewModellable {
    var inputs: ActivitiesViewModelInputs { get }
    var outputs: ActivitiesViewModelOutputs { get }
}

struct ActivitiesViewModelInputs {}

struct ActivitiesViewModelOutputs {}

class ActivitiesViewModel: ActivitiesViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ActivitiesViewModelInputs()
    let outputs = ActivitiesViewModelOutputs()
    var useCase: ActivitiesInteractable

    init(useCase: ActivitiesInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension ActivitiesViewModel {

    func setupObservables() {}
}
