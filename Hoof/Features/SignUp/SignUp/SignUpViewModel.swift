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

struct SignUpViewModelInputs {
    var signUpButtonTapped = PublishSubject<(userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int)>()
}

struct SignUpViewModelOutputs {
    var showCreateProfile = PublishSubject<(email: String, password: String)>()
}

class SignUpViewModel: SignUpViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = SignUpViewModelInputs()
    let outputs = SignUpViewModelOutputs()
    var useCase: SignUpInteractable
    
    init(useCase: SignUpInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension SignUpViewModel {
    
    func setupObservables() {
        inputs.signUpButtonTapped.subscribe(onNext: { [weak self] (userName: String, email: String, password: String, gender: String, bio: String, favoritePosition: String, foot: String, preferedNumber: Int) in
                        
            guard let self = self else { return }
            
            self.outputs.showCreateProfile.onNext((email: email, password: password))
            /*
            self.useCase.signUp(userName: userName, email: email, password: password, gender: gender, bio: bio, favoritePosition: favoritePosition, foot: foot, preferedNumber: preferedNumber)
                .subscribe { event in
                    switch event {
                    case let .success(result):
                        print("User created succcefully")
                    case let .error(error):
                        print("Error occured while creating a user")
                    }
                }.disposed(by: self.disposeBag)
             */
        }).disposed(by: disposeBag)
    }
}
