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
    var dismiss = PublishSubject<(AthleteActivity?)>()
}

struct DiscussionViewModelOutputs {
    var updateView = PublishSubject<AthleteActivityComment>()
    var dismiss = PublishSubject<(AthleteActivity?)>()
	var refreshView = PublishSubject<()>()
}

class DiscussionViewModel: DiscussionViewModellable {
    
    let disposeBag = DisposeBag()
    let inputs = DiscussionViewModelInputs()
    let outputs = DiscussionViewModelOutputs()
    var useCase: DiscussionInteractable
    
    var activity: AthleteActivity
    
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
                case let .success(athlete):
                    print("User commented on the post successfully")
					guard let firstName = athlete?.first_name, let lastName = athlete?.last_name, let imageURL = athlete?.imageUrl, let gender = athlete?.gender else {
						return
					}

					self.outputs.updateView.onNext(AthleteActivityComment(id: "", user_id: userId, text: comment, creator: Athlete(user_id: userId, first_name: firstName, last_name: lastName, imageUrl: imageURL, gender: gender, followersCount: 0, followingCount: 0)))
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
						self.activity.likes.removeAll {
							$0.creator?.user_id == userId
						}
						self.outputs.refreshView.onNext(())
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
							self.activity.likes.append(AthleteActivityLike(id: likeId, creator: Athlete(user_id: userId, first_name: "", last_name: "", imageUrl: "", gender: "", followersCount: 0, followingCount: 0)))
							self.outputs.refreshView.onNext(())
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
