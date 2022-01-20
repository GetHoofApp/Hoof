//
//  HomeCoordinator.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
//import Discussion

class HomeCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let discussionModuleBuilder: DiscussionModuleBuildable

    var showDiscussion = PublishSubject<(Activity)>()
    var updateComments = PublishSubject<[Comment]?>()

    init(rootViewController: NavigationControllable?, viewController: UIViewController, discussionModuleBuilder: DiscussionModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.discussionModuleBuilder = discussionModuleBuilder
    }
    
    override public func start() -> Observable<Void> {        
        rootViewController?.setViewControllers([viewController], animated: true)

        showDiscussion.subscribe { [weak self] event in
            guard let self = self else { return }

            if let activity = event.element {
                guard let rootViewController = self.rootViewController, let discussionCoordinator: BaseCoordinator<[Comment]?> = self.discussionModuleBuilder.buildModule(with: rootViewController, activity: activity)?.coordinator else {
                    preconditionFailure("Cannot get signupModuleCoordinator from module builder")
                }
                
                self.coordinate(to: discussionCoordinator).subscribe(onNext: { [weak self] comments in
                    print("comments: \(comments)")
                    guard let self = self else { return }
                    
                    self.updateComments.onNext((comments))
                }).disposed(by: self.disposeBag)
            }
        }.disposed(by: disposeBag)

        return .never()
    }
}
