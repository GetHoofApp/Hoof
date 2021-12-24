//
//  SceneDelegate.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 25/10/2021.
//

import UIKit
import RxSwift
import Core
import GoogleMaps

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var rootBuilder = RootBuilder()
    private let disposeBag = DisposeBag()
    private var appRootCoordinator: BaseCoordinator<Void>?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
            
            appRootCoordinator = rootBuilder.buildModule(with: window)?.coordinator
            guard let appRootCoordinator = appRootCoordinator else {
                preconditionFailure("[SceneDelegate] Cannot get appRootCoordinator from module builder")
            }
            
            UIUtil.setBasicAppearance()
            
            appRootCoordinator.start()
                .subscribe()
                .disposed(by: disposeBag)
        }
    }
}

open class UIUtil {
    
    public static func setBasicAppearance() {
        UITabBar.appearance().isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)], for: .selected)
        
        UITabBar.appearance().tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
    }

}
