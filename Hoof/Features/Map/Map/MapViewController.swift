//
//  MapViewController.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class MapViewController: ViewController<MapViewModel> {
    
	override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        setupObservers()
        
        view.backgroundColor = .white
    }
    
    override func setupConstraints() {}
    
    func setupSubviews() {}
    
    private func setupNavogationBar() {
        title = "Discover"
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupObservers() {}
}
