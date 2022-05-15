//
//  ProfileViewModel.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol ProfileViewModellable: ViewModellable {
    var inputs: ProfileViewModelInputs { get }
    var outputs: ProfileViewModelOutputs { get }
}

struct ProfileViewModelInputs {
    var editProfileButtonTapped = PublishSubject<(profilePhotoURL: String, firstName: String, lastName: String, gender: String)>()
}

struct ProfileViewModelOutputs {
    var showUpdateProfile = PublishSubject<(profilePhotoURL: String, firstName: String, lastName: String, gender: String)>()
}

class ProfileViewModel: ProfileViewModellable {

    let disposeBag = DisposeBag()
    let inputs = ProfileViewModelInputs()
    let outputs = ProfileViewModelOutputs()
    var useCase: ProfileInteractable

    init(useCase: ProfileInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension ProfileViewModel {

    func setupObservables() {
        inputs.editProfileButtonTapped.subscribe(onNext: { [weak self] (profilePhotoURL, firstName, lastName, gender) in
            self?.outputs.showUpdateProfile.onNext((profilePhotoURL: profilePhotoURL, firstName: firstName, lastName: lastName, gender: gender))
        }).disposed(by: disposeBag)
    }
}
