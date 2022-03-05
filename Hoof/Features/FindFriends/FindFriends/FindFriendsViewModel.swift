//
//  FindFriendsViewModel.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

protocol FindFriendsViewModellable: ViewModellable {
    var disposeBag: DisposeBag { get }
    var inputs: FindFriendsViewModelInputs { get }
    var outputs: FindFriendsViewModelOutputs { get }
}

struct FindFriendsViewModelInputs {
    var viewState = PublishSubject<ViewState>()
    var followOrUnfollowButtonTapped = PublishSubject<(String, Bool)>()
    var followOrUnfollowAllButtonTapped = PublishSubject<([String], Bool)>()
    var searchForAthletesTriggered = PublishSubject<String>()
}

struct FindFriendsViewModelOutputs {
    let viewData = PublishSubject<FindFriendsViewController.ViewData>()
    let showAthletesSearchResult = PublishSubject<FindFriendsViewController.ViewData>()
}

class FindFriendsViewModel: FindFriendsViewModellable {
    let disposeBag = DisposeBag()
    let inputs = FindFriendsViewModelInputs()
    let outputs = FindFriendsViewModelOutputs()
    var useCase: FindFriendsInteractable
    
    private var suggestedAthletes = [User]()

    init(useCase: FindFriendsInteractable) {
        self.useCase = useCase
        
        setupObservables()
    }
}

// MARK: - Observables

private extension FindFriendsViewModel {
    
    func setupObservables() {
        inputs.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loaded, .refresh:
                self.fetchSuggestedAthletes()
            default:
                break
            }
        }).disposed(by: disposeBag)
        
        inputs.followOrUnfollowButtonTapped.subscribe(onNext: { [weak self] (userToFollowOrUnfollowID, shouldFollow) in
            guard let self = self else { return }
            
            if shouldFollow {
                self.useCase.followUser(userID: "7", userToFollowID: userToFollowOrUnfollowID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User followed successfully")
                    case .error:
#warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            } else {
                self.useCase.unfollowUser(userID: "7", userToUnfollowID: userToFollowOrUnfollowID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User unfollowed successfully")
                    case .error:
#warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)

        inputs.followOrUnfollowAllButtonTapped.subscribe(onNext: { [weak self] (userIdsToFollowOrUnfollow, shouldFollowAll) in
            guard let self = self else { return }
            
            if shouldFollowAll {
                self.useCase.followAll(userID: "7", usersIdsToFollow: userIdsToFollowOrUnfollow).subscribe({ event in
                    switch event {
                    case .success:
                        print("User followed All successfully")
                        self.suggestedAthletes.forEach { user in
                            user.isAthleteFollowed = true
                        }
                        self.outputs.viewData.onNext(FindFriendsViewController.ViewData(suggestedAthletes: self.suggestedAthletes))
                    case .error:
#warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            } else {
                self.useCase.unfollowAll(userID: "7", usersIdsToUnfollow: userIdsToFollowOrUnfollow).subscribe({ event in
                    switch event {
                    case .success:
                        print("User unfollowed All successfully")
                        self.suggestedAthletes.forEach { user in
                            user.isAthleteFollowed = false
                        }
                        self.outputs.viewData.onNext(FindFriendsViewController.ViewData(suggestedAthletes: self.suggestedAthletes))
                    case .error:
#warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)

        
        inputs.searchForAthletesTriggered.subscribe(onNext: { [weak self] query in
            guard let self = self else { return }
            
            self.useCase.searchUsers(query: query).subscribe { event in
                switch event {
                case let .success(athletes):
                    let suggestedAthletes = athletes.compactMap { $0 }
                    self.outputs.showAthletesSearchResult.onNext(FindFriendsViewController.ViewData(suggestedAthletes: suggestedAthletes))
                case .error:
                    break
                }
            }.disposed(by: self.disposeBag)
            
        }).disposed(by: disposeBag)
    }
}

private extension FindFriendsViewModel {
    
    func fetchSuggestedAthletes() {
        self.useCase.fetchSuggestedAthletes(userID: 7).subscribe { event in
            switch event {
            case let .success(athletes):
                let suggestedAthletes = athletes.compactMap { $0 }
                self.suggestedAthletes = suggestedAthletes
                self.outputs.viewData.onNext(FindFriendsViewController.ViewData(suggestedAthletes: suggestedAthletes))
            case .error:
                break
            }
        }.disposed(by: self.disposeBag)
    }
}
