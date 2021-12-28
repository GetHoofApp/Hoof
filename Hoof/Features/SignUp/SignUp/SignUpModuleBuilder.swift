//
//  SignUpModuleBuilder.swift
//  SignUp
//
//  Created Sameh Mabrouk on 27/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol SignUpModuleBuildable: ModuleBuildable {}

public class SignUpModuleBuilder: Builder<EmptyDependency>, SignUpModuleBuildable {

    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
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
        container.register(SignUpServicePerforming.self) {
            return SignUpService()
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
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(SignUpCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(SignUpViewController.self) else {
                return nil
            }
            
            let coordinator = SignUpCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
