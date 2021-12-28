//
//  WelcomeViewModel.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol WelcomeViewModellable: ViewModellable {
    var inputs: WelcomeViewModelInputs { get }
    var outputs: WelcomeViewModelOutputs { get }
}

struct WelcomeViewModelInputs {
    var signupButtonTapped = PublishSubject<Void>()
}

struct WelcomeViewModelOutputs {
    var showSignUp = PublishSubject<Void>()
}

class WelcomeViewModel: WelcomeViewModellable {

    let disposeBag = DisposeBag()
    let inputs = WelcomeViewModelInputs()
    let outputs = WelcomeViewModelOutputs()
    var useCase: WelcomeInteractable

    init(useCase: WelcomeInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension WelcomeViewModel {

    func setupObservables() {
        inputs.signupButtonTapped.subscribe(onNext: { [weak self] in
            self?.outputs.showSignUp.onNext(())
        }).disposed(by: disposeBag)
    }
}
