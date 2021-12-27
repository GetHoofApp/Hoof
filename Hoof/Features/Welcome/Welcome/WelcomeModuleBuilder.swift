//
//  WelcomeModuleBuilder.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol WelcomeModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>?
}

public class WelcomeModuleBuilder: Builder<EmptyDependency>, WelcomeModuleBuildable {

    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(WelcomeCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension WelcomeModuleBuilder {
    
    func registerUsecase() {
        container.register(WelcomeInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(WelcomeServicePerforming.self) else { return nil }
            return WelcomeUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(WelcomeServicePerforming.self) {
            return WelcomeService()
        }
    }
    
    func registerViewModel() {
        container.register(WelcomeViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(WelcomeInteractable.self) else { return nil }
            
            return WelcomeViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(WelcomeViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(WelcomeViewModel.self) else {
                return nil
            }
            
            return WelcomeViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(WelcomeCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(WelcomeViewController.self) else {
                return nil
            }
            
            let coordinator = WelcomeCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
