//
//  SignInViewModel.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol SignInViewModellable: ViewModellable {
    var inputs: SignInViewModelInputs { get }
    var outputs: SignInViewModelOutputs { get }
}

struct SignInViewModelInputs {
	var signInButtonTapped = PublishSubject<(email: String, password: String)>()
}

struct SignInViewModelOutputs {
	var userSignedIn = PublishSubject<String>()
}

class SignInViewModel: SignInViewModellable {

    let disposeBag = DisposeBag()
    let inputs = SignInViewModelInputs()
    let outputs = SignInViewModelOutputs()
    var useCase: SignInInteractable

    init(useCase: SignInInteractable) {
        self.useCase = useCase

		setupObservables()
    }
}

// MARK: - Observables

private extension SignInViewModel {

	func setupObservables() {
		inputs.signInButtonTapped.subscribe(onNext: { [weak self] (email: String, password: String) in

			guard let self = self else { return }

			self.useCase.signIn(email: email, password: password).subscribe { event in
				switch event {
				case let .success(result):
					if let result = result {
						print("User signed in succcefully")
						self.outputs.userSignedIn.onNext((result))
					}
				case let .error(error):
					print("Error occured while signing in: ", error)
				}
			}.disposed(by: self.disposeBag)
		}).disposed(by: disposeBag)
	}
}
