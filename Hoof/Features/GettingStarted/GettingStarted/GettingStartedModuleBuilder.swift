//
//  GettingStartedModuleBuilder.swift
//  GettingStarted
//
//  Created Sameh Mabrouk on 05/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

protocol GettingStartedModuleBuildable: ModuleBuildable {}

class GettingStartedModuleBuilder: GettingStartedModuleBuildable {
    
    private let container: DependencyManager
    
    public init(container: DependencyManager) {
        self.container = container
    }
    
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(GettingStartedCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension GettingStartedModuleBuilder {
    
    func registerUsecase() {
        container.register(GettingStartedInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(GettingStartedServicePerforming.self) else { return nil }
            return GettingStartedUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(ServiceErrorListener.self) { TemperServiceErrorListener() }
        container.register(CoreConfiguration.self) { CoreConfiguration.sharedInstance }
        container.register(GraphQLClientProtocol.self) { [weak self] in
            guard let coreConfiguration = self?.container.resolve(CoreConfiguration.self) else { return nil }
            return GraphQLClient(withConfiguration: coreConfiguration)
        }
        
        container.register(GettingStartedServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self),
                let listener = self?.container.resolve(ServiceErrorListener.self) else { return nil }
            return GettingStartedService(client: client, serviceErrorListener: listener)
        }
    }
    
    func registerViewModel() {
        container.register(GettingStartedViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(GettingStartedInteractable.self) else { return nil }
            
            return GettingStartedViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(GettingStartedViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(GettingStartedViewModel.self) else {
                return nil
            }
            
            return GettingStartedViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(GettingStartedCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(GettingStartedViewController.self) else {
                return nil
            }
            
            let coordinator = GettingStartedCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
