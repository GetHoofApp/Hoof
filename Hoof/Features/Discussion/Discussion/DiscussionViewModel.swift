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
	var likeButtonTapped = PublishSubject<(AthleteActivity, String, String, String?, Bool)>()
    var sendButtonTapped = PublishSubject<(String, String, String)>()
    var dismiss = PublishSubject<([AthleteActivityComment]?)>()
}

struct DiscussionViewModelOutputs {
    var updateView = PublishSubject<AthleteActivityComment>()
    var dismiss = PublishSubject<([AthleteActivityComment]?)>()
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
        inputs.sendButtonTapped.subscribe(onNext: { [weak self] (activityId, activityUserId, comment) in
            guard let self = self, let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

            self.useCase.commentOnPost(activityUserID: activityUserId, userId: userId, activityId:activityId , comment: comment).subscribe({ event in
                switch event {
                case .success:
                    print("User commented on the post successfully")
                    self.outputs.updateView.onNext(AthleteActivityComment(id: "", user_id: userId, text: comment))
                case .error:
                    #warning("TODO: Show in app notification for graphql error")
                    break
                }
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
        
		inputs.likeButtonTapped.subscribe(onNext: { [weak self] (activity, postUserId, postId, likeId, isActivityLiked) in
			guard let self = self, let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

			if isActivityLiked, let likeId = likeId {
				self.useCase.unlikePost(userID: postUserId, postID: postId, likeId: likeId).subscribe({ event in
					switch event {
					case .success:
						print("User unliked the post successfully")

					case .error:
					#warning("TODO: Show in app notification for graphql error")
						break
					}
				}).disposed(by: self.disposeBag)
			} else {
				self.useCase.likePost(postUserID: postUserId, userId: userId, postID: postId).subscribe({ event in
					switch event {
					case let .success(docId):
						if let likeId = docId {
						}
						print("User liked the post successfully")
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
