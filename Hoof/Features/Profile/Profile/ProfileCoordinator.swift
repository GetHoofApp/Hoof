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
import Home

class ProfileCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: NavigationControllable?
    private let viewController: UIViewController
    private let updateProfileModuleBuilder: UpdateProfileModuleBuildable
	private let homeModuleBuilder: HomeModuleBuildable
    
    var showUpdateProfile = PublishSubject<(profilePhotoURL: String?, firstName: String, lastName: String, gender: String?)>()
	var showActivities = PublishSubject<()>()

    init(rootViewController:  NavigationControllable?, viewController: UIViewController, updateProfileModuleBuilder: UpdateProfileModuleBuildable, homeModuleBuilder: HomeModuleBuildable) {
        self.rootViewController = rootViewController
        self.viewController = viewController
        self.updateProfileModuleBuilder = updateProfileModuleBuilder
		self.homeModuleBuilder = homeModuleBuilder
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

		showActivities.subscribe { [weak self] _ in
			guard let self = self else { return }

			guard let rootViewController = self.rootViewController, let updateProfileCoordinator: BaseCoordinator<Void> = self.homeModuleBuilder.buildModule(with: rootViewController, isShowingActivities: true)?.coordinator else {
				preconditionFailure("[AppCoordinator] Cannot get homeModuleBuilder from module builder")
			}

			self.coordinate(to: updateProfileCoordinator).subscribe(onNext: {
			}).disposed(by: self.disposeBag)
		}.disposed(by: disposeBag)
        
        return .never()
    }
}
