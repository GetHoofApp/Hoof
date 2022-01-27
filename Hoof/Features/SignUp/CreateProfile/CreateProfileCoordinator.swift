//
//  CreateProfileCoordinator.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class CreateProfileCoordinator: BaseCoordinator<String> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    
    var userCreated = PublishSubject<String>()

    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<String> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return userCreated
    }
}
