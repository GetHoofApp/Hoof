//
//  MapModuleBuilder.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Utils
import Components
import Core

protocol MapModuleBuildable: ModuleBuildable {}

class MapModuleBuilder: MapModuleBuildable {
    
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
        
        guard let coordinator = container.resolve(MapCoordinator.self) else {
            return nil
        }
        
        return Module(coordinator: coordinator) as? Module<T>
    }
}

private extension MapModuleBuilder {
    
    func registerUsecase() {
        container.register(MapInteractable.self) { [weak self] in
            guard let self = self,
                let service = self.container.resolve(MapServicePerforming.self) else { return nil }
            return MapUseCase(service: service)
        }
    }
    
    func registerService() {
        container.register(ServiceErrorListener.self) { TemperServiceErrorListener() }
        container.register(CoreConfiguration.self) { CoreConfiguration.sharedInstance }
        container.register(GraphQLClientProtocol.self) { [weak self] in
            guard let coreConfiguration = self?.container.resolve(CoreConfiguration.self) else { return nil }
            return GraphQLClient(withConfiguration: coreConfiguration)
        }
        
        container.register(MapServicePerforming.self) { [weak self] in
            guard let client = self?.container.resolve(GraphQLClientProtocol.self),
                let listener = self?.container.resolve(ServiceErrorListener.self) else { return nil }
            return MapService(client: client, serviceErrorListener: listener)
        }
    }
    
    func registerViewModel() {
        container.register(MapViewModel.self) { [weak self] in
            guard let useCase = self?.container.resolve(MapInteractable.self) else { return nil }
            
            return MapViewModel(useCase: useCase)
        }
    }
    
    func registerView() {
        container.register(MapViewController.self) { [weak self] in
            guard let viewModel = self?.container.resolve(MapViewModel.self) else {
                return nil
            }
            
            return MapViewController.instantiate(with: viewModel)
        }
    }
    
    func registerCoordinator(rootViewController: NavigationControllable? = nil) {
        container.register(MapCoordinator.self) { [weak self] in
            guard let viewController = self?.container.resolve(MapViewController.self) else {
                return nil
            }
            
            let coordinator = MapCoordinator(rootViewController: rootViewController, viewController: viewController)
            return coordinator
        }
    }
}
