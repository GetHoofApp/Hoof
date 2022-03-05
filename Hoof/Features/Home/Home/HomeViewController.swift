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
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAthleteActivities), for: .valueChanged)
        return refreshControl
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
        navigationItem.title = "Home"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        navigationItem.title = " "
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 243/255, alpha: 1.0)
        tableView.refreshControl = refreshControl
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
        
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0.0
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        let findFriendsButton = UIButton(type: .custom)
        findFriendsButton.setImage(UIImage(named: "people"), for: .normal)
        findFriendsButton.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        findFriendsButton.addTarget(self, action: #selector(findFriendsButtonTapped), for: .touchUpInside)
        let findFriendsBarButtonItem = UIBarButtonItem(customView: findFriendsButton)
        navigationItem.leftBarButtonItem = findFriendsBarButtonItem
    }
    
    override func setupObservers() {
        viewModel.outputs.viewData
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }

                self.activities = viewData.activities
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }).disposed(by: viewModel.disposeBag)
        
        commentButtonTapped.take(1).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.inputs.commentButtonTapped.onNext(self.selectedActivity)
        }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.showRefreshControl
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }

                self.refreshControl.beginRefreshing()
            }).disposed(by: viewModel.disposeBag)
        
        commentButtonTapped.take(1).subscribe(onNext: { [weak self] _ in
            guard let self = self else { return }
            
            self.viewModel.inputs.commentButtonTapped.onNext(self.selectedActivity)
        }).disposed(by: viewModel.disposeBag)
    }
    
    @objc func findFriendsButtonTapped() {
        viewModel.inputs.findFriendsButtonTapped.onNext(())
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        activities.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 20
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

extension HomeViewController {
    
    @objc func refreshAthleteActivities() {
        viewModel.inputs.viewState.onNext(.refresh)
    }
}
