//
//  HomeModuleBuilder.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import FindFriends
import Alamofire

private final class HomeDependencyProvider: DependencyProvider<EmptyDependency> {
        
    var discussionModuleBuilder: DiscussionModuleBuildable {
        DiscussionModuleBuilder()
    }
    
    var findFriendsModuleBuilder: FindFriendsModuleBuildable {
        FindFriendsModuleBuilder()
    }

	var session: SessionManager { SessionManager.default }
}

public protocol HomeModuleBuildable: ModuleBuildable {
	func buildModule<T>(with rootViewController: NavigationControllable, isShowingActivities: Bool) -> Module<T>?
	func buildModule<T>(with rootViewController: NavigationControllable, shouldDoSomethings: Bool) -> Module<T>?
}

public class HomeModuleBuilder: Builder<EmptyDependency>, HomeModuleBuildable {

	public func buildModule<T>(with rootViewController: NavigationControllable, shouldDoSomethings: Bool) -> Module<T>? {
		return nil
	}

	public func buildModule<T>(with rootViewController: NavigationControllable, isShowingActivities: Bool) -> Module<T>? {
        let dependencyProvider = HomeDependencyProvider()

		registerService(session: dependencyProvider.session)
        registerUsecase()
        registerViewModel(isShowingActivities:isShowingActivities)
        registerView()
        registerCoordinator(rootViewController: rootViewController, discussionModuleBuilder: dependencyProvider.discussionModuleBuilder, findFriendsModuleBuilder: dependencyProvider.findFriendsModuleBuilder, isShowingActivities: isShowingActivities)
        
        guard let coordinator = container.resolve(HomeCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension HomeModuleBuilder {
    
    func registerUsecase() {
        container.register(HomeInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(HomeServiceFetching.self) else { return nil }
            return HomeUseCase(service: service)
        }
    }
    
	func registerService(session: SessionManager) {
        container.register(GraphQLClientProtocol.self) {
            return GraphQLClient()
        }

        container.register(HomeServiceFetching.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self) else { return nil }
            return HomeService(client: client, session: session)
        }
    }
    
	func registerViewModel(isShowingActivities: Bool) {
        container.register(HomeViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(HomeInteractable.self) else { return nil }
            
            return HomeViewModel(useCase: useCase, isShowingActivities: isShowingActivities)
        }
    }
    
    func registerView() {
        container.register(HomeViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(HomeViewModel.self) else {
                return nil
            }
            
            return HomeViewController.instantiate(with: viewModel)
        }
    }
    
	func registerCoordinator(rootViewController: NavigationControllable? = nil, discussionModuleBuilder: DiscussionModuleBuildable, findFriendsModuleBuilder: FindFriendsModuleBuildable, isShowingActivities: Bool) {
        container.register(HomeCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(HomeViewController.self) else {
                return nil
            }
            
            let coordinator = HomeCoordinator(rootViewController: rootViewController, viewController: viewController, discussionModuleBuilder: discussionModuleBuilder, findFriendsModuleBuilder: findFriendsModuleBuilder, isShowingActivities: isShowingActivities)
            coordinator.showDiscussion = viewController.viewModel.outputs.showDiscussion
            coordinator.showFindFriends = viewController.viewModel.outputs.showFindFriends
            viewController.viewModel.updateComments = coordinator.updateComments
            return coordinator
        }
    }
}
