//
//  ChallengesViewModel.swift
//  Groups
//
//  Created by Sameh Mabrouk on 24/11/2021.
//

import Core

import RxSwift
import Core

protocol ChallengesViewModellable: ViewModellable {
    var disposeBag: DisposeBag { get }
    var inputs: ChallengesViewModelInputs { get }
    var outputs: ChallengesViewModelOutputs { get }
}

struct ChallengesViewModelInputs {
    var createGroupChallengeButtonTapped = PublishSubject<Void>()
    var followOrUnfollowButtonTapped = PublishSubject<Void>()    
}

struct ChallengesViewModelOutputs {
    var showCreateChallengeModule = PublishSubject<Void>()
}

class ChallengesViewModel: ChallengesViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = ChallengesViewModelInputs()
    let outputs = ChallengesViewModelOutputs()

    init() {
        setupObservables()
    }
}

// MARK: - Observables

private extension ChallengesViewModel {

    func setupObservables() {
        inputs.createGroupChallengeButtonTapped.subscribe { [weak self] _ in
            guard let self = self else { return }
            
            self.outputs.showCreateChallengeModule.onNext(())
        }.disposed(by: disposeBag)
    }
}
