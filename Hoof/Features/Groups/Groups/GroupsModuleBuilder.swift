//
//  GroupsModuleBuilder.swift
//  Groups
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol GroupsModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>?
}

public class GroupsModuleBuilder: Builder<EmptyDependency>, GroupsModuleBuildable {

    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(GroupsCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension GroupsModuleBuilder {
    
    func registerUsecase() {
        container.register(GroupsInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(GroupsServicePerforming.self) else { return nil }
            return GroupsUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GroupsServicePerforming.self) {
            return GroupsService()
        }
    }
    
    func registerViewModel() {
        container.register(GroupsViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(GroupsInteractable.self) else { return nil }
            
            return GroupsViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(GroupsPageViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(GroupsViewModel.self) else {
                return nil
            }

//            return GroupsViewController.instantiate(with: viewModel)
            return GroupsPageViewController(groupsViewController: GroupsViewController.instantiate(with: viewModel), challengesViewController: ChallengesViewController(), activeViewController: ActiveViewController())
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(GroupsCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(GroupsPageViewController.self) else {
                return nil
            }
            
            let coordinator = GroupsCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
