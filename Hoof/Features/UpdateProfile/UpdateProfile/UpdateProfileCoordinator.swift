//
//  UpdateProfileCoordinator.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core

class UpdateProfileCoordinator: BaseCoordinator<Void> {
    
    private weak var rootViewController: Presentable?
    private let viewController: UINavigationController
    
    var dismiss = PublishSubject<Void>()

    init(rootViewController: Presentable?, viewController: UINavigationController) {
        self.rootViewController = rootViewController
        self.viewController = viewController
    }
    
    override public func start() -> Observable<Void> {
        rootViewController?.presentInFullScreen(viewController, animated: true, completion: nil)
        
        return dismiss.do(onNext: { [weak self] in
            self?.viewController.dismiss(animated: true, completion: nil)
        })
    }
}
