//
//  SignUpCoordinator.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class SignUpCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let createProfileModuleBuilder: CreateProfileModuleBuildable
    
    var showCreateProfile = PublishSubject<(email: String, password: String)>()

    init(rootViewController: NavigationControllable?, viewController: UIViewController, createProfileModuleBuilder: CreateProfileModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.createProfileModuleBuilder = createProfileModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.pushViewController(viewController, animated: true)
        
        showCreateProfile.subscribe { [weak self] (email, password) in
            guard let self = self else { return }

            guard let rootViewController = self.rootViewController, let createProfileModuleCoordinator: BaseCoordinator<Void> = self.createProfileModuleBuilder.buildModule(with: email, password: password, rootViewController: rootViewController)?.coordinator else {
                preconditionFailure("Cannot get createProfileModuleCoordinator from module builder")
            }
            
            self.coordinate(to: createProfileModuleCoordinator).subscribe(onNext: {
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return .never()
    }
}
