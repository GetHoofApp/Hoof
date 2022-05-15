//
//  UpdateProfileModuleBuilder.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

public protocol UpdateProfileModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: Presentable, profilePhotoURL: String, firstName: String, lastName: String, gender: String) -> Module<T>?
}

public class UpdateProfileModuleBuilder: Builder<EmptyDependency>, UpdateProfileModuleBuildable {
    
    public func buildModule<T>(with rootViewController: Presentable, profilePhotoURL: String, firstName: String, lastName: String, gender: String) -> Module<T>? {
        registerService()
        registerUsecase()
        registerViewModel(profilePhotoURL: profilePhotoURL, firstName: firstName, lastName: lastName, gender: gender)
        registerView()
        registerCoordinator(rootViewController: rootViewController)
        
        guard let coordinator = container.resolve(UpdateProfileCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension UpdateProfileModuleBuilder {
    
    func registerUsecase() {
        container.register(UpdateProfileInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(UpdateProfileServicePerforming.self) else { return nil }
            return UpdateProfileUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }
        container.register(UpdateProfileServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return UpdateProfileService(client: client)
        }
    }
    
    func registerViewModel(profilePhotoURL: String, firstName: String, lastName: String, gender: String) {
        container.register(UpdateProfileViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(UpdateProfileInteractable.self) else { return nil }
            
            return UpdateProfileViewModel(useCase: useCase, viewData: UpdateProfileViewController.ViewData(imageURL: profilePhotoURL, firstName: firstName, lastName: lastName, gender: gender))
        }
    }
    
    func registerView() {
        container.register(NavigationControllable.self) { [weak self] in
            guard let viewModel = self?.container.resolve(UpdateProfileViewModel.self) else {
                return nil
            }
            
            let viewController = UpdateProfileViewController.instantiate(with: viewModel)
            return UINavigationController(rootViewController: viewController)
        }
    }
    
    func registerCoordinator(rootViewController: Presentable? = nil) {
        container.register(UpdateProfileCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(NavigationControllable.self) as? UINavigationController else {
                return nil
            }
            
            let coordinator = UpdateProfileCoordinator(rootViewController: rootViewController, viewController: viewController)
            if let viewController = (viewController.topViewController as? UpdateProfileViewController) {
                coordinator.dismiss = viewController.viewModel.outputs.dismiss
            }

            return coordinator
        }
    }
}
