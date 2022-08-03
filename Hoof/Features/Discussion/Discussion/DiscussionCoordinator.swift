//
//  DiscussionCoordinator.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class DiscussionCoordinator: BaseCoordinator<[AthleteActivityComment]?> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    
    var dismiss = PublishSubject<([AthleteActivityComment]?)>()
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<[AthleteActivityComment]?> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return dismiss.map { [weak self] (comments) in
//            let _ = self?.rootViewController?.popViewController(animated: true)
            return comments
        }
    }
}
