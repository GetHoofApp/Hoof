//
//  HomeModuleBuilder.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol HomeModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>?
}

public class HomeModuleBuilder: Builder<EmptyDependency>, HomeModuleBuildable {

    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(HomeCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension HomeModuleBuilder {
    
    func registerUsecase() {
        container.register(HomeInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(HomeServiceFetching.self) else { return nil }
            return HomeUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        container.register(HomeServiceFetching.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return HomeService(client: client)
        }
    }
    
    func registerViewModel() {
        container.register(HomeViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(HomeInteractable.self) else { return nil }
            
            return HomeViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(HomeViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(HomeViewModel.self) else {
                return nil
            }
            
            return HomeViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(HomeCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(HomeViewController.self) else {
                return nil
            }
            
            let coordinator = HomeCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
