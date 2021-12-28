//
//  WelcomeCoordinator.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import SignUp

class WelcomeCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let signUpModuleBuilder: SignUpModuleBuildable
    
    var showSignUp = PublishSubject<Void>()
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController, signUpModuleBuilder: SignUpModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.signUpModuleBuilder = signUpModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.setViewControllers([viewController], animated: true)

        showSignUp.subscribe { [weak self] _ in
            guard let self = self else { return }

            guard let rootViewController = self.rootViewController, let signupModuleCoordinator: BaseCoordinator<Void> = self.signUpModuleBuilder.buildModule(with: rootViewController)?.coordinator else {
                preconditionFailure("Cannot get signupModuleCoordinator from module builder")
            }
            
            self.coordinate(to: signupModuleCoordinator).subscribe(onNext: {
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return .never()
    }
}
