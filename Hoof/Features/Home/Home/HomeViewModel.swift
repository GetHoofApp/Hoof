//
//  HomeViewModel.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import Core
import RxSwift
import CoreGPX

protocol HomeViewModellable: ViewModellable {
    var inputs: HomeViewModelInputs { get }
    var outputs: HomeViewModelOutputs { get }
}

struct HomeViewModelInputs {
    var viewState = PublishSubject<ViewState>()
    var likeButtonTapped = PublishSubject<(AthleteActivity, String, String, String?, Bool)>()
    var commentButtonTapped = PublishSubject<(AthleteActivity)>()
    var findFriendsButtonTapped = PublishSubject<Void>()
}

struct HomeViewModelOutputs {
    let viewData = PublishSubject<HomeViewController.ViewData>()
    let showRefreshControl = PublishSubject<Void>()
    let showDiscussion = PublishSubject<(AthleteActivity)>()
    let showFindFriends = PublishSubject<(Void)>()
	let shouldShowNavigationBar = PublishSubject<(Bool)>()
}

class HomeViewModel: HomeViewModellable {
    
    let disposeBag = DisposeBag()
    var inputs = HomeViewModelInputs()
    let outputs = HomeViewModelOutputs()
    var useCase: HomeInteractable
	var isLoadingMore = false
	var isShowingActivities = false {
		didSet {
//			self.outputs.shouldShowNavigationBar.onNext(isShowingActivities)
		}
	}
    
    private var activities = [AthleteActivity]()
    private var selectedActivity: AthleteActivity!
    var updateComments = PublishSubject<AthleteActivity?>()
	{
        didSet {
            updateComments.subscribe(onNext: { [weak self] activity in
				guard let self = self, let comments = activity?.comments, let likes = activity?.likes else { return }

                if let index = self.activities.firstIndex(where: { $0.id == self.selectedActivity.id }) {
                    self.activities[index].comments = comments
					self.activities[index].likes = likes
                }

                self.outputs.viewData.onNext(HomeViewController.ViewData(activities: self.activities))

            }).disposed(by: disposeBag)
        }
    }

	private var lastVisibleUserId: String!
	private var lastVisibleActivityId: String!

	init(useCase: HomeInteractable, isShowingActivities: Bool) {
        self.useCase = useCase
		self.isShowingActivities = isShowingActivities

        setupObservables()
    }
}

// MARK: - Observables

private extension HomeViewModel {
    
    func setupObservables() {
        NotificationCenter.default.addObserver(self, selector: #selector(reloadActivities), name: .didReceiveFileFromAppleWatch, object: nil)
        
        inputs.viewState.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            
            switch state {
			case .loaded, .refresh:
				fallthrough
			case .loadMore:
				self.isLoadingMore = true
            default:
                break
            }

			if self.isShowingActivities {
				self.fetchAthleteActivities()
			} else {
				self.fetchAthleteActivitiesTimeline()
			}
        }).disposed(by: disposeBag)
        
        inputs.likeButtonTapped.subscribe(onNext: { [weak self] (activity, postUserId, postId, likeId, isActivityLiked) in
            guard let self = self, let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }
			
            if isActivityLiked, let likeId = likeId {
				self.useCase.unlikePost(userID: postUserId, postID: postId, likeId: likeId).subscribe({ event in
					switch event {
					case .success:
						print("User unliked the post successfully")
						if let activityIndex = self.activities.firstIndex(where: {$0.id == postId}) {
							self.activities[activityIndex].likes.removeAll { $0.creator?.user_id == userId }
							self.outputs.viewData.onNext(HomeViewController.ViewData(activities: self.activities))
						}
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
//							let activity = self.activities.first { $0.id == postId }
//							var like = activity?.likes.first(where: { $0.user_id == userId })
//							like?.id = likeId

							if let activityIndex = self.activities.firstIndex(where: {$0.id == postId}) {
								self.activities[activityIndex].likes.append(AthleteActivityLike(id: likeId, creator: Athlete(user_id: userId, first_name: "", last_name: "", imageUrl: "", gender: "", followersCount: 0, followingCount: 0)))
//								self.activities[activityIndex].likes[likeIndex].id = likeId
								self.outputs.viewData.onNext(HomeViewController.ViewData(activities: self.activities))
							}
//							if let index = self.activities.firstIndex(where: {$0.id == postId}) {
//								self.activities[index].likes.first(where: { $0.user_id == userId }) {
//
//								}
//							}
						}
						print("User liked the post successfully")
					case .error:
					#warning("TODO: Show in app notification for graphql error")
						break
					}
				}).disposed(by: self.disposeBag)
            }
        }).disposed(by: disposeBag)
        
        inputs.commentButtonTapped.subscribe(onNext: { [weak self] activity in
            self?.selectedActivity = activity
            self?.outputs.showDiscussion.onNext(activity)
        }).disposed(by: disposeBag)
        
        inputs.findFriendsButtonTapped.subscribe(onNext: { [weak self] activity in
            self?.outputs.showFindFriends.onNext(())
        }).disposed(by: disposeBag)
    }
}

private extension HomeViewModel {
    
    @objc func reloadActivities() {
        print("[DEBUG] HomeViewModel: reload activities")
        outputs.showRefreshControl.onNext(())
		if isShowingActivities {
			fetchAthleteActivities()
		} else {
			fetchAthleteActivitiesTimeline()
		}
    }
    
    func fetchAthleteActivitiesTimeline() {
		guard let userID = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

		let lastVisibleUserId = ((self.lastVisibleUserId != nil && self.lastVisibleUserId.isEmpty) ? "" : self.lastVisibleUserId) ?? ""
		self.useCase.fetchAthleteActivties(userID: userID, lastVisibleUserId: lastVisibleUserId, limit: 3).subscribe { event in
			switch event {
			case let .success(posts):
				let activities = posts.compactMap { $0 }
				self.activities.append(contentsOf: activities)
				self.lastVisibleUserId = self.activities.last?.user_id
				self.outputs.shouldShowNavigationBar.onNext(self.isShowingActivities)
				if self.lastVisibleActivityId != self.activities.last?.id {
					self.lastVisibleActivityId = self.activities.last?.id
					self.outputs.viewData.onNext(HomeViewController.ViewData(activities: self.activities))
				}
				self.isLoadingMore = false
			case .error:
				break
			}
		}.disposed(by: self.disposeBag)
    }

	func fetchAthleteActivities() {
		let lastVisibleActivityId = ((self.lastVisibleActivityId != nil && self.lastVisibleActivityId.isEmpty) ? "" : self.lastVisibleActivityId) ?? ""

		self.useCase.fetchMyActivities(lastVisibleActivityId: lastVisibleActivityId, limit: 3).subscribe { event in
			switch event {
			case let .success(posts):
				let activities = posts.compactMap { $0 }
				self.activities.append(contentsOf: activities)
				self.lastVisibleUserId = self.activities.last?.user_id
				self.outputs.shouldShowNavigationBar.onNext(self.isShowingActivities)
				if self.lastVisibleActivityId != self.activities.last?.id {
					self.lastVisibleActivityId = self.activities.last?.id
					self.outputs.viewData.onNext(HomeViewController.ViewData(activities: self.activities))
				}
				self.isLoadingMore = false
			case .error:
				break
			}
		}.disposed(by: self.disposeBag)
	}
}

