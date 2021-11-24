//
//  GroupsViewModel.swift
//  Groups
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol GroupsViewModellable: ViewModellable {
    var disposeBag: DisposeBag { get }
    var inputs: GroupsViewModelInputs { get }
    var outputs: GroupsViewModelOutputs { get }
}

struct GroupsViewModelInputs {
    var createGroupChallengeButtonTapped = PublishSubject<Void>()
}

struct GroupsViewModelOutputs {
    var showCreateChallengeModule = PublishSubject<Void>()
}

class GroupsViewModel: GroupsViewModellable {

    let disposeBag = DisposeBag()
    let inputs = GroupsViewModelInputs()
    let outputs = GroupsViewModelOutputs()
    var useCase: GroupsInteractable

    init(useCase: GroupsInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension GroupsViewModel {

    func setupObservables() {
        inputs.createGroupChallengeButtonTapped.subscribe { [weak self] _ in
            guard let self = self else { return }
            
            self.outputs.showCreateChallengeModule.onNext(())
        }.disposed(by: disposeBag)
    }
}
