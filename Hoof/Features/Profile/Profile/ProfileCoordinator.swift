//
//  ProfileCoordinator.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import UpdateProfile

class ProfileCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let updateProfileModuleBuilder: UpdateProfileModuleBuildable
    
    var showUpdateProfile = PublishSubject<(profilePhotoURL: String?, firstName: String, lastName: String, gender: String?)>()

    init(rootViewController:  NavigationControllable?, viewController: UIViewController, updateProfileModuleBuilder: UpdateProfileModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.updateProfileModuleBuilder = updateProfileModuleBuilder
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.setViewControllers([viewController], animated: true)
        
        showUpdateProfile.subscribe { [weak self] event in
            guard let self = self else { return }
            
            if let element = event.element {
                guard let rootViewController = self.rootViewController as? Presentable, let updateProfileCoordinator: BaseCoordinator<Void> = self.updateProfileModuleBuilder.buildModule(with: rootViewController, profilePhotoURL: element.profilePhotoURL, firstName: element.firstName, lastName: element.lastName, gender: element.gender)?.coordinator else {
                    preconditionFailure("Cannot get updateProfileCoordinator from module builder")
                }
                
                self.coordinate(to: updateProfileCoordinator).subscribe(onNext: {
                }).disposed(by: self.disposeBag)
            }
        }.disposed(by: disposeBag)
        
        return .never()
    }
}
