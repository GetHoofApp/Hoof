//
//  CreateChallengeCoordinator.swift
//  CreateChallenge
//
//  Created Sameh Mabrouk on 24/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class CreateChallengeCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: Presentable?
    private let viewController: UIViewController
    
    init(rootViewController: Presentable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.present(viewController, animated: true, completion: nil)
        
        return .never()
    }
}
