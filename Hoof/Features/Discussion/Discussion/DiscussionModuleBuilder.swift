//
//  DiscussionModuleBuilder.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol DiscussionModuleBuildable: ModuleBuildable {
    func buildModule(with rootViewController: NavigationControllable, activity: AthleteActivity) -> Module<AthleteActivity?>?
}

public class DiscussionModuleBuilder: Builder<EmptyDependency>, DiscussionModuleBuildable {
    
    public func buildModule(with rootViewController: NavigationControllable, activity: AthleteActivity) -> Module<AthleteActivity?>? {
        registerService()
        registerUsecase()
        registerViewModel(activity: activity)
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(DiscussionCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator)
    }
}

private extension DiscussionModuleBuilder {
    
    func registerUsecase() {
        container.register(DiscussionInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(DiscussionServicePerforming.self) else { return nil }
            return DiscussionUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        
        container.register(DiscussionServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return DiscussionService(client: client)
        }
    }
    
    func registerViewModel(activity: AthleteActivity) {
        container.register(DiscussionViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(DiscussionInteractable.self) else { return nil }
            
            return DiscussionViewModel(useCase: useCase, activity: activity)
        }
    }
    
    func registerView() {
        container.register(DiscussionViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(DiscussionViewModel.self) else {
                return nil
            }
            
            return DiscussionViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(DiscussionCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(DiscussionViewController.self) else {
                return nil
            }
            
            let coordinator = DiscussionCoordinator(rootViewController: rootViewController, viewController: viewController)
            coordinator.dismiss = viewController.viewModel.outputs.dismiss
            return coordinator
        }
    }
}
