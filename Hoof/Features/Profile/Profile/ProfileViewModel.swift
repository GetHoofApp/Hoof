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
	var viewState = PublishSubject<ViewState>()
    var editProfileButtonTapped = PublishSubject<(profilePhotoURL: String?, firstName: String, lastName: String, gender: String?)>()
	var activitiesCellTapped = PublishSubject<()>()
}

struct ProfileViewModelOutputs {
	let viewData = PublishSubject<ProfileViewController.ViewData>()
    var showUpdateProfile = PublishSubject<(profilePhotoURL: String?, firstName: String, lastName: String, gender: String?)>()
	var showActivities = PublishSubject<()>()
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

		inputs.activitiesCellTapped.subscribe(onNext: { [weak self] in
			self?.outputs.showActivities.onNext(())
		}).disposed(by: disposeBag)

		inputs.viewState.subscribe(onNext: { [weak self] state in
			guard let self = self else { return }

			switch state {
			case .loaded:
				self.useCase.fetchAthleteProfile().subscribe({ event in
					switch event {
					case let .success(athlete):
						print("Successfully fetched Athlete profile")
						if let athlete = athlete {
							self.outputs.viewData.onNext(ProfileViewController.ViewData(athlete: athlete))
						}
					case .error:
						break
					}
				}).disposed(by: self.disposeBag)
			default:
				break
			}
		}).disposed(by: disposeBag)
    }
}
