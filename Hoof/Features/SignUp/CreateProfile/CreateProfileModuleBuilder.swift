//
//  CreateProfileModuleBuilder.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

protocol CreateProfileModuleBuildable: ModuleBuildable {}

class CreateProfileModuleBuilder: CreateProfileModuleBuildable {
    
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
        
        guard let coordinator = container.resolve(CreateProfileCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension CreateProfileModuleBuilder {
    
    func registerUsecase() {
        container.register(CreateProfileInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(CreateProfileServicePerforming.self) else { return nil }
            return CreateProfileUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        container.register(CreateProfileServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return CreateProfileService(client: client)
        }
    }
    
    func registerViewModel() {
        container.register(CreateProfileViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(CreateProfileInteractable.self) else { return nil }
            
            return CreateProfileViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(CreateProfileViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(CreateProfileViewModel.self) else {
                return nil
            }
            
            return CreateProfileViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(CreateProfileCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(CreateProfileViewController.self) else {
                return nil
            }
            
            let coordinator = CreateProfileCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
