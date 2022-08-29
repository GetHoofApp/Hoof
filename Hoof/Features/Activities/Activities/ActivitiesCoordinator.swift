//
//  ActivitiesCoordinator.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class ActivitiesCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return .never()
    }
}
