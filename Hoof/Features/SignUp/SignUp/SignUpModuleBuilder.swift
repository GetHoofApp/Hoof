//
//  SignUpModuleBuilder.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

private final class SignUpDependencyProvider: DependencyProvider<EmptyDependency> {
        
    var createProfileModuleBuilder: CreateProfileModuleBuildable {
        CreateProfileModuleBuilder()
    }
}

public protocol SignUpModuleBuildable: ModuleBuildable {}

public class SignUpModuleBuilder: Builder<EmptyDependency>, SignUpModuleBuildable {

    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        let dependencyProvider = SignUpDependencyProvider()

        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController, createProfileModuleBuilder: dependencyProvider.createProfileModuleBuilder)
        
        guard let coordinator = container.resolve(SignUpCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension SignUpModuleBuilder {
    
    func registerUsecase() {
        container.register(SignUpInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(SignUpServicePerforming.self) else { return nil }
            return SignUpUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        container.register(SignUpServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return SignUpService(client: client)
        }
    }
    
    func registerViewModel() {
        container.register(SignUpViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(SignUpInteractable.self) else { return nil }
            
            return SignUpViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(SignUpViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(SignUpViewModel.self) else {
                return nil
            }
            
            return SignUpViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil, createProfileModuleBuilder: CreateProfileModuleBuildable) {
        container.register(SignUpCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(SignUpViewController.self) else {
                return nil
            }
            
            let coordinator = SignUpCoordinator(rootViewController: rootViewController, viewController: viewController, createProfileModuleBuilder: createProfileModuleBuilder)
            coordinator.showCreateProfile = viewController.viewModel.outputs.showCreateProfile
            return coordinator
        }
    }
}
