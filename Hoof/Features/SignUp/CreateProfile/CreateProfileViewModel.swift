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

struct CreateProfileViewModelInputs {
    var continueButtonTapped = PublishSubject<(firstName: String, lastName: String, gender: String)>()
}

struct CreateProfileViewModelOutputs {
    let showDiscussion = PublishSubject<(Activity)>()
    var userCreated = PublishSubject<String>()
}

class CreateProfileViewModel: CreateProfileViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = CreateProfileViewModelInputs()
    let outputs = CreateProfileViewModelOutputs()
    private let useCase: CreateProfileInteractable
    private let email: String
    private let password: String
    
    
    init(useCase: CreateProfileInteractable, email: String, password: String) {
        self.useCase = useCase
        self.email = email
        self.password = password
        
        setupObservables()
    }
}

// MARK: - Observables

private extension CreateProfileViewModel {
    
    func setupObservables() {
        inputs.continueButtonTapped.subscribe(onNext: { [weak self] (firstName: String, lastName: String, gender: String) in
            
            guard let self = self else { return }
            
            self.useCase.createProfile(firstName: firstName, lastName: lastName, email: self.email, password: self.password, gender: gender)
                .subscribe { event in
                    switch event {
                    case let .success(result):
                        self.outputs.userCreated.onNext((result))
                        print("User created succcefully")
                    case let .error(error):
                        print("Error occured while creating a user")
                    }
                }.disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    }
}
