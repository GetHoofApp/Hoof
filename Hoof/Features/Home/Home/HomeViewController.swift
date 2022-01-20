//
//  HomeViewController.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import GoogleMaps
import GoogleMapsUtils
import RxSwift
import CodableGeoJSON
import RxCocoa

class HomeViewController: ViewController<HomeViewModel> {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(withType: ActivityCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var activities = [Activity]()
    let commentButtonTapped = PublishSubject<Void>()
    var selectedActivity: Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyAQEtHPhRoMo1EoXu8FS_459wrEtyEBfSo")

        setupUI()
        
        viewModel.inputs.viewState.onNext(.loaded)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupObservers()
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 243/255, alpha: 1.0)
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupNavogationBar() {
        title = "Home"
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func setupObservers() {
        viewModel.outputs.viewData
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }

                self.activities = viewData.activities
                self.tableView.reloadData()
            }).disposed(by: viewModel.disposeBag)
        
        commentButtonTapped.take(1).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.inputs.commentButtonTapped.onNext(self.selectedActivity)
        }).disposed(by: viewModel.disposeBag)
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        activities.count
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        activities.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 10
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(forType: ActivityCell.self)
        let activity = activities[indexPath.section]
        selectedActivity = activity
        cell.likeButtonTap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.inputs.likeButtonTapped.onNext((activity.id, activity.isActivityLiked))
            })
            .disposed(by: viewModel.disposeBag)

        cell.commentButtonTap
            .subscribe(onNext: { [weak self] in
                self?.viewModel.inputs.commentButtonTapped.onNext(activity)
            })
            .disposed(by: cell.disposeBag)

        cell.configure(withActivity: activity)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension HomeViewController {
    
    struct ViewData {
        let activities: [Activity]
    }
}
