//
//  MapModuleBuilder.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import CoreLocation

/// Provides all dependencies to build the MapModuleBuilder
private final class MapDependencyProvider: DependencyProvider<EmptyDependency> {
    
    fileprivate var locationManager: CLLocationManager { CLLocationManager() }
}

public protocol MapModuleBuildable: ModuleBuildable {
    func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>?
}

public class MapModuleBuilder: Builder<EmptyDependency>, MapModuleBuildable {
    
    public func buildModule<T>(with rootViewController: NavigationControllable) -> Module<T>? {
        let mapDependencyProvider = MapDependencyProvider()

        registerService(locationManager: mapDependencyProvider.locationManager)
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
                  let service = self.container.resolve(MapServicePerforming.self),
                  let locationService = self.container.resolve(LocationServiceChecking.self) else { return nil }
            return MapUseCase(service: service, locationService: locationService)
        }
    }
    
    func registerService(locationManager: CLLocationManager) {
        container.register(MapServicePerforming.self) {
            return MapService()
        }
        
        container.register(LocationServiceChecking.self) {
            return LocationService(locationManager: locationManager)
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
