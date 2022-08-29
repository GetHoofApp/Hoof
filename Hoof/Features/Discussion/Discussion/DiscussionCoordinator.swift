//
//  DiscussionCoordinator.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class DiscussionCoordinator: BaseCoordinator<AthleteActivity?> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    
    var dismiss = PublishSubject<(AthleteActivity?)>()
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<AthleteActivity?> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return dismiss.map { (activity) in
//            let _ = self?.rootViewController?.popViewController(animated: true)
            return activity
        }
    }
}
