//
//  ProfileModuleBuilder.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import UpdateProfile
import Home

private final class ProfileDependencyProvider: DependencyProvider<EmptyDependency> {
        
    var updateProfileModuleBuilder: UpdateProfileModuleBuildable {
        UpdateProfileModuleBuilder()
    }

	var homeModuleBuilder: HomeModuleBuildable {
		HomeModuleBuilder()
	}
}

public protocol ProfileModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>?
}

public class ProfileModuleBuilder: Builder<EmptyDependency>, ProfileModuleBuildable {
    
    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        let dependencyProvider = ProfileDependencyProvider()

        registerService()
        registerUsecase()
        registerViewModel()
        registerView()
		registerCoordinator(rootViewController: rootViewController, updateProfileModuleBuilder: dependencyProvider.updateProfileModuleBuilder, homeModuleBuilder: dependencyProvider.homeModuleBuilder)
        
        guard let coordinator = container.resolve(ProfileCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension ProfileModuleBuilder {
    
    func registerUsecase() {
        container.register(ProfileInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(ProfileServicePerforming.self) else { return nil }
            return ProfileUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(ProfileServicePerforming.self) {
            return ProfileService()
        }
    }
    
    func registerViewModel() {
        container.register(ProfileViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(ProfileInteractable.self) else { return nil }
            
            return ProfileViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(ProfileViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(ProfileViewModel.self) else {
                return nil
            }
            
            return ProfileViewController.instantiate(with: viewModel)
        }
    }
    
	func registerCoordinator(rootViewController: NavigationControllable? = nil, updateProfileModuleBuilder: UpdateProfileModuleBuildable, homeModuleBuilder: HomeModuleBuildable) {
        container.register(ProfileCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(ProfileViewController.self) else {
                return nil
            }
            
            let coordinator = ProfileCoordinator(rootViewController: rootViewController, viewController: viewController, updateProfileModuleBuilder: updateProfileModuleBuilder, homeModuleBuilder: homeModuleBuilder)
            coordinator.showUpdateProfile = viewController.viewModel.outputs.showUpdateProfile
			coordinator.showActivities = viewController.viewModel.outputs.showActivities
            return coordinator
        }
    }
}
