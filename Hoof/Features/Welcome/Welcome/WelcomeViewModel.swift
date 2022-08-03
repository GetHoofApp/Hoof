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
    var signUpButtonTapped = PublishSubject<Void>()
	var signInButtonTapped = PublishSubject<Void>()
}

struct WelcomeViewModelOutputs {
    var showSignUp = PublishSubject<Void>()
	var showSignIn = PublishSubject<Void>()
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
        inputs.signUpButtonTapped.subscribe(onNext: { [weak self] in
            self?.outputs.showSignUp.onNext(())
        }).disposed(by: disposeBag)

		inputs.signInButtonTapped.subscribe(onNext: { [weak self] in
			self?.outputs.showSignIn.onNext(())
		}).disposed(by: disposeBag)
    }
}
