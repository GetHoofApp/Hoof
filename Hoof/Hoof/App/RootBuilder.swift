//
//  RootBuilder.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 10/11/2021.
//

import Core
import Home
import UIKit
import Map

/// Provides all dependencies to build the AppRootCoordinator
private final class RootDependencyProvider: DependencyProvider<EmptyDependency> {
        
    fileprivate var homeModuleBuilder: HomeModuleBuildable {
        HomeModuleBuilder()
    }
    
    fileprivate var mapModuleBuilder: MapModuleBuildable {
        MapModuleBuilder()
    }
}

protocol RootBuildable: ModuleBuildable {}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    
    // MARK: - RootBuildable
    
    func buildModule<T>(with window: UIWindow) -> Module<T>? {
        let dependencyProvider = RootDependencyProvider()
        let appRootCoordinator = AppRootCoordinator(window: window, homeModuleBuilder: dependencyProvider.homeModuleBuilder, mapModuleBuilder: dependencyProvider.mapModuleBuilder)
        
        return Module(coordinator: appRootCoordinator) as? Module<T>
    }
}
