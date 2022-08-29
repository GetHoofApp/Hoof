//
//  ActivitiesModuleBuilder.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

protocol ActivitiesModuleBuildable: ModuleBuildable {}

class ActivitiesModuleBuilder: ActivitiesModuleBuildable {
    
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
        
        guard let coordinator = container.resolve(ActivitiesCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension ActivitiesModuleBuilder {
    
    func registerUsecase() {
        container.register(ActivitiesInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(ActivitiesServicePerforming.self) else { return nil }
            return ActivitiesUseCase(service: service)
        }
    }
    
    func registerViewModel() {
        container.register(ActivitiesViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(ActivitiesInteractable.self) else { return nil }
            
            return ActivitiesViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(ActivitiesViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(ActivitiesViewModel.self) else {
                return nil
            }
            
            return ActivitiesViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(ActivitiesCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(ActivitiesViewController.self) else {
                return nil
            }
            
            let coordinator = ActivitiesCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
