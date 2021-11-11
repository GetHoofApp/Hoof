//
//  HomeViewModel.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Core
import RxSwift

protocol HomeViewModellable: ViewModellable {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModelInputs {}

struct HomeViewModelOutputs {}

class HomeViewModel: HomeViewModellable {
    let disposeBag = DisposeBag()

    let inputs = HomeViewModelInputs()
    let outputs = HomeViewModelOutputs()
    var useCase: HomeInteractable

    init(useCase: HomeInteractable) {
        self.useCase = useCase
    }
}

// MARK: - Observables

private extension HomeViewModel {

    func setupObservables() {}
}
