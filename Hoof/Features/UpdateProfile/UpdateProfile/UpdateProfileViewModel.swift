//
//  UpdateProfileViewModel.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol UpdateProfileViewModellable: ViewModellable {
    var inputs: UpdateProfileViewModelInputs { get }
    var outputs: UpdateProfileViewModelOutputs { get }
}

struct UpdateProfileViewModelInputs {
    var viewState = PublishSubject<ViewState>()
	var continueButtonTapped = PublishSubject<(firstName: String, lastName: String, gender: String, logo: UIImage?)>()
    var cancelButtonTapped = PublishSubject<Void>()
}

struct UpdateProfileViewModelOutputs {
    var viewData = PublishSubject<UpdateProfileViewController.ViewData>()
    var dismiss = PublishSubject<Void>()
}

class UpdateProfileViewModel: UpdateProfileViewModellable {
    
    private let viewData: UpdateProfileViewController.ViewData
    private let useCase: UpdateProfileInteractable
    let disposeBag = DisposeBag()
    let inputs = UpdateProfileViewModelInputs()
    let outputs = UpdateProfileViewModelOutputs()
    
    init(useCase: UpdateProfileInteractable, viewData: UpdateProfileViewController.ViewData) {
        self.useCase = useCase
        self.viewData = viewData
        
        setupObservables()
    }
}

// MARK: - Observables

private extension UpdateProfileViewModel {
    
    func setupObservables() {
        inputs.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loaded:
                self.outputs.viewData.onNext(self.viewData)
            default:
                break
            }
        }).disposed(by: disposeBag)
        
		inputs.continueButtonTapped.subscribe(onNext: { [weak self] (firstName: String, lastName: String, gender: String, logo: UIImage?) in
            
            guard let self = self else { return }

            self.useCase.updateProfile(firstName: firstName, lastName: lastName, gender: gender, logo: logo, userID: "")
                .subscribe { event in
                    switch event {
                    case let .success:
//                        self.outputs.userCreated.onNext((result))
                        print("User updated succcefully")
						self.outputs.dismiss.onNext(())
                    case let .error(error):
                        print("Error occured while creating a user: \(error)")
                    }
                }.disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        inputs.cancelButtonTapped.subscribe(onNext: { [weak self] activity in
            self?.outputs.dismiss.onNext(())
        }).disposed(by: disposeBag)
    }
}
