//
//  SignInModuleBuilder.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import FirebaseAuth

private final class HomeDependencyProvider: DependencyProvider<EmptyDependency> {
	var firebaseAuth: Auth { Auth.auth() }
}

public protocol SignInModuleBuildable: ModuleBuildable {}

public class SignInModuleBuilder: Builder<EmptyDependency>, SignInModuleBuildable {

	public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
		let dependencyProvider = HomeDependencyProvider()

		registerService(firebaseAuth: dependencyProvider.firebaseAuth)
		registerUsecase()
		registerViewModel()
		registerView()
		registerCoordinator(rootViewController: rootViewController)

		guard let coordinator = container.resolve(SignInCoordinator.self) else {
			return nil
		}

		return Module(coordinator: coordinator) as? Module<T>
	}
}

private extension SignInModuleBuilder {

	func registerUsecase() {
		container.register(SignInInteractable.self) { [weak self] in
			guard let self = self,
				  let service = self.container.resolve(SignInServicePerforming.self) else { return nil }
			return SignInUseCase(service: service)
		}
	}

	func registerService(firebaseAuth: Auth) {
		container.register(SignInServicePerforming.self) {

			return SignInService(firebaseAuth: firebaseAuth)
		}
	}

	func registerViewModel() {
		container.register(SignInViewModel.self) { [weak self] in
			guard let useCase = self?.container.resolve(SignInInteractable.self) else { return nil }

			return SignInViewModel(useCase: useCase)
		}
	}

	func registerView() {
		container.register(SignInViewController.self) { [weak self] in
			guard let viewModel = self?.container.resolve(SignInViewModel.self) else {
				return nil
			}

			return SignInViewController.instantiate(with: viewModel)
		}
	}

	func registerCoordinator(rootViewController: NavigationControllable? = nil) {
		container.register(SignInCoordinator.self) { [weak self] in
			guard let viewController = self?.container.resolve(SignInViewController.self) else {
				return nil
			}

			let coordinator = SignInCoordinator(rootViewController: rootViewController, viewController: viewController)
			coordinator.userSignedIn = viewController.viewModel.outputs.userSignedIn
			return coordinator
		}
	}
}
