//
//  GroupsCoordinator.swift
//  Groups
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import CreateChallenge

class GroupsCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let createChallengeModuleBuilder: CreateChallengeModuleBuildable
    
    var showCreateChallengeModule: PublishSubject<Void>!
    
    init(rootViewController: NavigationControllable?, viewController: UIViewController, createChallengeModuleBuilder: CreateChallengeModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.createChallengeModuleBuilder = createChallengeModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.setViewControllers([viewController], animated: true)
        
        showCreateChallengeModule.subscribe { [weak self] _ in
            guard let self = self else { return }
            
            guard let createChallengeCoordinator: BaseCoordinator<Void> = self.createChallengeModuleBuilder.buildModule(with: self.viewController)?.coordinator else {
                preconditionFailure("Cannot get createChallengeCoordinator from module builder")
            }
            
            self.coordinate(to: createChallengeCoordinator).subscribe(onNext: {
            }).disposed(by: self.disposeBag)
        }.disposed(by: disposeBag)
        
        return .never()
    }
}
