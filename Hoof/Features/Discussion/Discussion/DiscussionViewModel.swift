//
//  DiscussionViewModel.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import Core
import RxSwift

protocol DiscussionViewModellable: ViewModellable {
    var inputs: DiscussionViewModelInputs { get }
    var outputs: DiscussionViewModelOutputs { get }
}

struct DiscussionViewModelInputs {
    var likeButtonTapped = PublishSubject<(String, Bool)>()
    var sendButtonTapped = PublishSubject<(String, String)>()
    var dismiss = PublishSubject<([Comment]?)>()
}

struct DiscussionViewModelOutputs {
    var updateView = PublishSubject<Comment>()
    var dismiss = PublishSubject<([Comment]?)>()
}

class DiscussionViewModel: DiscussionViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = DiscussionViewModelInputs()
    let outputs = DiscussionViewModelOutputs()
    var useCase: DiscussionInteractable
    
    let activity: AthleteActivity
    
    init(useCase: DiscussionInteractable, activity: AthleteActivity) {
        self.useCase = useCase
        self.activity = activity
        
        setupObservables()
    }
}

// MARK: - Observables

private extension DiscussionViewModel {
    
    func setupObservables() {
        inputs.sendButtonTapped.subscribe(onNext: { [weak self] (postID, message) in
            guard let self = self else { return }
            
            
            self.useCase.commentOnPost(userID: "7", postID: postID, message: message).subscribe({ event in
                switch event {
                case .success:
                    print("User commented on the post successfully")
                    self.outputs.updateView.onNext(Comment(id: "", message: message))
                case .error:
                    #warning("TODO: Show in app notification for graphql error")
                    break
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
        inputs.likeButtonTapped.subscribe(onNext: { [weak self] (postID, shouldLike) in
            guard let self = self else { return }

            if shouldLike {
                self.useCase.likePost(userID: "7", postID: postID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User liked the post successfully")
                    case .error:
                    #warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            } else {
                self.useCase.unlikePost(userID: "7", postID: postID).subscribe({ event in
                    switch event {
                    case .success:
                        print("User unliked the post successfully")
                    case .error:
                    #warning("TODO: Show in app notification for graphql error")
                        break
                    }
                }).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
        
        inputs.dismiss.subscribe(onNext: { [weak self] comments in
            guard let self = self else { return }
            
            self.outputs.dismiss.onNext(comments)
        }).disposed(by: disposeBag)
    }
}
