//
//  FindFriendsModuleBuilder.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol FindFriendsModuleBuildable: ModuleBuildable {}

public class FindFriendsModuleBuilder: Builder<EmptyDependency>, FindFriendsModuleBuildable {
    
    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(FindFriendsCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension FindFriendsModuleBuilder {
    
    func registerUsecase() {
        container.register(FindFriendsInteractable.self) { [weak self] in
            guard let self = self,
                  let service = self.container.resolve(FindFriendsServicePerforming.self) else {
                return nil
            }
            return FindFriendsUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        container.register(FindFriendsServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else {
                return nil
            }
            return FindFriendsService(client: client)
        }
    }
    
    func registerViewModel() {
        container.register(FindFriendsViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(FindFriendsInteractable.self) else {
                return nil
            }
            
            return FindFriendsViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(FindFriendsViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(FindFriendsViewModel.self) else {
                return nil
            }
            
            return FindFriendsViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(FindFriendsCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(FindFriendsViewController.self) else {
                return nil
            }
            
            let coordinator = FindFriendsCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
