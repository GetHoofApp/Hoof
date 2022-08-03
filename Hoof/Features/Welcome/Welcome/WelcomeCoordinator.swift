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
import SignIn

class WelcomeCoordinator: BaseCoordinator<String> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let signUpModuleBuilder: SignUpModuleBuildable
	private let signInModuleBuilder: SignInModuleBuildable
    
    var showSignUp = PublishSubject<Void>()
	var showSignIn = PublishSubject<Void>()
    var userCreated = PublishSubject<String>()
	var userSignedIn = PublishSubject<String>()

    init(rootViewController: NavigationControllable?, viewController: UIViewController, signUpModuleBuilder: SignUpModuleBuildable, signInModuleBuilder: SignInModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.signUpModuleBuilder = signUpModuleBuilder
		self.signInModuleBuilder = signInModuleBuilder
    }
    
    override public func start() -> Observable<String> {
        rootViewController?.setViewControllers([viewController], animated: true)

        showSignUp.subscribe { [weak self] _ in
            guard let self = self else { return }

            guard let rootViewController = self.rootViewController, let signupModuleCoordinator: BaseCoordinator<String> = self.signUpModuleBuilder.buildModule(with: rootViewController)?.coordinator else {
                preconditionFailure("Cannot get signupModuleCoordinator from module builder")
            }
            
            self.coordinate(to: signupModuleCoordinator).subscribe(onNext: { [weak self] userId in
                guard let self = self else { return }

                self.userCreated.onNext((userId))
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)

		showSignIn.subscribe { [weak self] _ in
			guard let self = self else { return }

			guard let rootViewController = self.rootViewController, let signInModuleCoordinator: BaseCoordinator<String> = self.signInModuleBuilder.buildModule(with: rootViewController)?.coordinator else {
				preconditionFailure("Cannot get signInModuleCoordinator from module builder")
			}

			self.coordinate(to: signInModuleCoordinator).subscribe(onNext: { [weak self] userId in
				guard let self = self else { return }

				self.userSignedIn.onNext((userId))
			}).disposed(by: self.disposeBag)
		}.disposed(by: disposeBag)
        
		return Observable.merge(userSignedIn , userCreated)
    }
}
