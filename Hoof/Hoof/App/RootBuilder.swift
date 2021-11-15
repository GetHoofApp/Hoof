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
import Groups
import Profile

/// Provides all dependencies to build the AppRootCoordinator
private final class RootDependencyProvider: DependencyProvider<EmptyDependency> {
        
    var homeModuleBuilder: HomeModuleBuildable {
        HomeModuleBuilder()
    }
    
    var mapModuleBuilder: MapModuleBuildable {
        MapModuleBuilder()
    }
    
    var groupsModuleBuilder: GroupsModuleBuildable {
        GroupsModuleBuilder()
    }
    
    var profileModuleBuilder: ProfileModuleBuildable {
        ProfileModuleBuilder()
    }
}

protocol RootBuildable: ModuleBuildable {}

final class RootBuilder: Builder<EmptyDependency>, RootBuildable {
    
    // MARK: - RootBuildable
    
    func buildModule<T>(with window: UIWindow) -> Module<T>? {
        let dependencyProvider = RootDependencyProvider()
        let appRootCoordinator = AppRootCoordinator(window: window, homeModuleBuilder: dependencyProvider.homeModuleBuilder, mapModuleBuilder: dependencyProvider.mapModuleBuilder, groupsModuleBuilder: dependencyProvider.groupsModuleBuilder, profileModuleBuilder: dependencyProvider.profileModuleBuilder)
        
        return Module(coordinator: appRootCoordinator) as? Module<T>
    }
}
