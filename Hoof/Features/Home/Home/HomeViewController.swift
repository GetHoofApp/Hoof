//
//  HomeViewController.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    typealias ViewModel = HomeViewModellable
	var viewModel: ViewModel!

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

// MARK: - setupUI

extension HomeViewController {

    func setupUI() {}

    func setupConstraints() {}

    func setupObservers() {}
}
