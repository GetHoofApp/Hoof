//
//  SignInCoordinator.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class SignInCoordinator: BaseCoordinator<String> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController

	var userSignedIn = PublishSubject<String>()

    init(rootViewController: NavigationControllable?, viewController: UIViewController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<String> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        return userSignedIn
    }
}
