//
//  CreateChallengeModuleBuilder.swift
//  CreateChallenge
//
//  Created Sameh Mabrouk on 24/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

protocol CreateChallengeModuleBuildable: ModuleBuildable {}

class CreateChallengeModuleBuilder: CreateChallengeModuleBuildable {
    
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
        
        guard let coordinator = container.resolve(CreateChallengeCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension CreateChallengeModuleBuilder {
    
    func registerUsecase() {
        container.register(CreateChallengeInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(CreateChallengeServicePerforming.self) else { return nil }
            return CreateChallengeUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(CreateChallengeServicePerforming.self) {
            return CreateChallengeService()
        }
    }
    
    func registerViewModel() {
        container.register(CreateChallengeViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(CreateChallengeInteractable.self) else { return nil }
            
            return CreateChallengeViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(CreateChallengeViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(CreateChallengeViewModel.self) else {
                return nil
            }
            
            return CreateChallengeViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(CreateChallengeCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(CreateChallengeViewController.self) else {
                return nil
            }
            
            let coordinator = CreateChallengeCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
