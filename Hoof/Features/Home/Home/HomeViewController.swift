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
        tableView.registerCell(withType: GettingStartedCell.self)
        tableView.registerCell(withType: GettingStartedHeaderCell.self)
        tableView.register(TableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewSectionHeader.self))
        tableView.register(TableViewSectionFooter.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewSectionFooter.self))
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

    private var activities = [AthleteActivity]()
    let commentButtonTapped = PublishSubject<Void>()
    var selectedActivity: AthleteActivity!
    let gettingStartedItems = [GettingStartedItem(image: #imageLiteral(resourceName: "smart-watch"), title: "Connect your GPS watch"), GettingStartedItem(image: #imageLiteral(resourceName: "football-shoe"), title: "Record your game using the watch app app"), GettingStartedItem(image: #imageLiteral(resourceName: "people"), title: "Follow friends and see their matches")]
    
    private var shouldShowGettingStartedView = false
    
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

                if viewData.activities.isEmpty {
                    
                }
                self.shouldShowGettingStartedView = viewData.activities.isEmpty
                
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
        return shouldShowGettingStartedView ? 4 : activities.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return shouldShowGettingStartedView ? ((section == 0 || section == 1) ? 0 : 0.2) : (section == 0 ? 0 : 20)
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    String(describing: TableViewSectionFooter.self)) as? TableViewSectionFooter else { return nil }
        if shouldShowGettingStartedView {
            view.tintColor = .white
        }
        
        return view
    }    
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard shouldShowGettingStartedView else {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    String(describing: TableViewSectionHeader.self)) as? TableViewSectionHeader else { return nil }
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

		if indexPath.section == activities.count - 1, !viewModel.isLoadingMore {
			// load more activities
			viewModel.inputs.viewState.onNext(.loadMore)
		}

        guard !shouldShowGettingStartedView else {
            if indexPath.section == 0 {
                let cell = tableView.getCell(forType: GettingStartedHeaderCell.self)
                return cell

            } else {
                let cell = tableView.getCell(forType: GettingStartedCell.self)
                cell.configure(gettingStartedItem: gettingStartedItems[indexPath.section - 1])
                return cell
            }
        }
        
        let cell = tableView.getCell(forType: ActivityCell.self)
        let activity = activities[indexPath.section]
        selectedActivity = activity
		cell.likeButtonTapped.take(1)
            .subscribe(onNext: { [weak self] in
				guard let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }
				let like = cell.activity.likes.first { $0.creator?.user_id == userId }
				self?.viewModel.inputs.likeButtonTapped.onNext((activity, cell.activity.user_id, cell.activity.id, like?.id, cell.activity.isActivityLiked(userId: userId)))
            })
            .disposed(by: cell.disposeBag)

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
        let activities: [AthleteActivity]
    }
    
    struct GettingStartedItem {
        let image: UIImage
        let title: String
    }
}

extension HomeViewController {
    
    @objc func refreshAthleteActivities() {
        viewModel.inputs.viewState.onNext(.refresh)
    }
}
