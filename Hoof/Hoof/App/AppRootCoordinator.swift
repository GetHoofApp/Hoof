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
import Map
import Groups
import Profile
import Welcome

class AppRootCoordinator: BaseCoordinator<Void> {
    
    private let window: UIWindow
    private let tabBarController: UITabBarController
    
    private var homeCoordinator: BaseCoordinator<Void>!
    private var mapCoordinator: BaseCoordinator<Void>!
    private var groupsCoordinator: BaseCoordinator<Void>!
    private var profileCoordinator: BaseCoordinator<Void>!
    
    private var welcomeCoordinator: BaseCoordinator<String>!

    private let homeModuleBuilder: HomeModuleBuildable
    private let mapModuleBuilder: MapModuleBuildable
    private let groupsModuleBuilder: GroupsModuleBuildable
    private let profileModuleBuilder: ProfileModuleBuildable
    
    private let welcomeModuleBuilder: WelcomeModuleBuildable
    
    init(window: UIWindow, homeModuleBuilder: HomeModuleBuildable, mapModuleBuilder: MapModuleBuildable, groupsModuleBuilder: GroupsModuleBuildable, profileModuleBuilder: ProfileModuleBuildable, welcomeModuleBuilder: WelcomeModuleBuildable) {
        self.window = window
        self.homeModuleBuilder = homeModuleBuilder
        self.mapModuleBuilder = mapModuleBuilder
        self.groupsModuleBuilder = groupsModuleBuilder
        self.profileModuleBuilder = profileModuleBuilder
        self.welcomeModuleBuilder = welcomeModuleBuilder
        tabBarController = UITabBarController()
    }
    
    override func start() -> Observable<Void> {
        guard let _ = UserDefaults.standard.value(forKey: "UserID") else {
            
            let navController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
            guard let welcomeCoordinator: BaseCoordinator<String> = welcomeModuleBuilder.buildModule(with: navController)?.coordinator else {
                preconditionFailure("[AppCoordinator] Cannot get welcomeModuleBuilder from module builder")
            }
            
            self.welcomeCoordinator = welcomeCoordinator
            _ = welcomeCoordinator.start().subscribe(onNext: { [weak self] userId in
                guard let self = self else { return }

                // Save userId to user defaults
                UserDefaults.standard.set(userId, forKey: "UserID")
                self.showMainTabBar()
            }).disposed(by: self.disposeBag)

            window.rootViewController = navController
            
            return .never()
        }
        
        showMainTabBar()

        return .never()
    }
}

private extension AppRootCoordinator {
    
    func showMainTabBar() {
        // Show tab bar
        let navController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let homeCoordinator: BaseCoordinator<Void> = self.homeModuleBuilder.buildModule(with: navController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get homeModuleBuilder from module builder")
        }
                
        let homeTabBarItem = UITabBarItem(title: "Home", image: #imageLiteral(resourceName: "Home"), selectedImage: #imageLiteral(resourceName: "Home-selected"))
        navController.tabBarItem = homeTabBarItem
        
        self.homeCoordinator = homeCoordinator
        _ = homeCoordinator.start()
        
        
        let mapNavController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let mapCoordinator: BaseCoordinator<Void> = self.mapModuleBuilder.buildModule(with: mapNavController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get mapModuleBuilder from module builder")
        }
        
        let mapTabBarItem = UITabBarItem(title: "Discover", image: #imageLiteral(resourceName: "Map"), selectedImage: #imageLiteral(resourceName: "Map"))
        mapNavController.tabBarItem = mapTabBarItem
        
        self.mapCoordinator = mapCoordinator
        _ = mapCoordinator.start()
        

        let groupsNavController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let groupsCoordinator: BaseCoordinator<Void> = self.groupsModuleBuilder.buildModule(with: groupsNavController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get groupsModuleBuilder from module builder")
        }
        
        let groupsTabBarItem = UITabBarItem(title: "Groups", image: #imageLiteral(resourceName: "Groups"), selectedImage: #imageLiteral(resourceName: "Groups"))
        groupsNavController.tabBarItem = groupsTabBarItem
        
        self.groupsCoordinator = groupsCoordinator
        _ = groupsCoordinator.start()
        
        let profileNavController = UINavigationController(navigationBarClass: nil, toolbarClass: nil)
        guard let profileCoordinator: BaseCoordinator<Void> = self.profileModuleBuilder.buildModule(with: profileNavController)?.coordinator else {
            preconditionFailure("[AppCoordinator] Cannot get groupsModuleBuilder from module builder")
        }
        
        let profileTabBarItem = UITabBarItem(title: "You", image: #imageLiteral(resourceName: "Profile"), selectedImage: #imageLiteral(resourceName: "Profile"))
        profileNavController.tabBarItem = profileTabBarItem
        
        self.profileCoordinator = profileCoordinator
        _ = profileCoordinator.start()
        
//         TabBar Appearance
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)], for: .normal)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)], for: .selected)
        
//        self.tabBarController.setViewControllers([navController, mapNavController, groupsNavController, profileNavController], animated: false)
		self.tabBarController.setViewControllers([navController, profileNavController], animated: false)
        self.window.rootViewController = self.tabBarController
    }
}
