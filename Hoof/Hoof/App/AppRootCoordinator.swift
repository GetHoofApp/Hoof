//
//  AppRootCoordinator.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 10/11/2021.
//

import UIKit
import Core
import RxSwift
import Home

class AppRootCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    private var homeCoordinator: BaseCoordinator<Void>!
    private let homeModuleBuilder: HomeModuleBuildable

    init(window: UIWindow, homeModuleBuilder: HomeModuleBuildable) {
        self.window = window
        self.homeModuleBuilder = homeModuleBuilder
        tabBarController = UITabBarController()
    }
    
    override func start() -> Observable<Void> {
        let navController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let homeCoordinator: BaseCoordinator<Void> = homeModuleBuilder.buildModule(with: navController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get peripheralsModuleBuilder from module builder")
        }
        
        self.homeCoordinator = homeCoordinator
        _ = homeCoordinator.start()
        
        let navController2 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController2.setViewControllers([UIViewController()], animated: true)
        
        let navController3 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController3.setViewControllers([UIViewController()], animated: true)
        
        let navController4 = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        navController4.setViewControllers([UIViewController()], animated: true)

        tabBarController.setViewControllers([navController, navController2, navController3, navController4], animated: false)
        window.rootViewController = tabBarController
        
        return .never()
    }
}
