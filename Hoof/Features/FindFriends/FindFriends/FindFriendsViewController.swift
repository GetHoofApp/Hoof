//
//  FindFriendsViewController.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import RxCocoa
import RxSwift

class FindFriendsViewController: ViewController<FindFriendsViewModel> {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(withType: FriendsCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(TableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewSectionHeader.self))
        tableView.register(FindFriendsTableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: FindFriendsTableViewSectionHeader.self))
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshAthleteActivities), for: .valueChanged)
        return refreshControl
    }()
    
    lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search for friends"
        
        return searchController
    }()
    
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    var isFiltering: Bool {
        return searchController.isActive && (!isSearchBarEmpty)
    }
    
    private var suggestedAthletes = [User]()
    private var filteredAthletes = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        setupSearchController()
        
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
        title = "Find Friends"
        
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0.0
        }
        
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    private func setupSearchController() {
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.searchBar.delegate = self
        
    }
    
    override func setupObservers() {
        viewModel.outputs.viewData
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }
                
                self.suggestedAthletes = viewData.suggestedAthletes
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.showAthletesSearchResult
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }
                
                self.filteredAthletes = viewData.suggestedAthletes
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }).disposed(by: viewModel.disposeBag)
    }
    
    @objc func findFriendsButtonTapped() {
    }
}

// MARK: - UITableViewDataSource

extension FindFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if isFiltering {
            return filteredAthletes.count
        }
        return suggestedAthletes.count
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 65 : 0.2
    }
    
    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 0 {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                        String(describing: FindFriendsTableViewSectionHeader.self)) as? FindFriendsTableViewSectionHeader else { return nil }
            view.followOrUnfollowButtonTap
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    
                    let suggestedAthletesIds = self.suggestedAthletes.map { $0.id }
                    
                    self.viewModel.inputs.followOrUnfollowAllButtonTapped.onNext((suggestedAthletesIds, view.areAllSuggestedAthletesFollowed))
                })
                .disposed(by: viewModel.disposeBag)
            
            return view
        } else {
            guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                        String(describing: TableViewSectionHeader.self)) as? TableViewSectionHeader else { return nil }
            
            return view
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(forType: FriendsCell.self)
        let suggestedAthlete: User
        if isFiltering {
            suggestedAthlete = filteredAthletes[indexPath.section]
        } else {
            suggestedAthlete = suggestedAthletes[indexPath.section]
        }
        cell.followOrUnfollowButtonTap
            .subscribe(onNext: { [weak self] in
                guard let self = self else { return }
                
                self.viewModel.inputs.followOrUnfollowButtonTapped.onNext((suggestedAthlete.id, suggestedAthlete.isAthleteFollowed))
            })
            .disposed(by: viewModel.disposeBag)
        cell.configure(with: suggestedAthlete)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension FindFriendsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension FindFriendsViewController {
    
    class SuggestedAthlete {
        let athleteImage: String
        let userName: String
        let suggestionReason: String
        let isAthleteFollowed: Bool
        
        init(athleteImage: String, userName: String, suggestionsReason: String, isAthleteFollowed: Bool) {
            self.athleteImage = athleteImage
            self.userName = userName
            self.suggestionReason = suggestionsReason
            self.isAthleteFollowed = isAthleteFollowed
        }
    }
    
    struct ViewData {
        let suggestedAthletes: [User]
    }
}

extension FindFriendsViewController {
    
    @objc func refreshAthleteActivities() {
        viewModel.inputs.viewState.onNext(.refresh)
    }
    
    func searchForAthletesWith(query: String) {
        if !isSearchBarEmpty {
            viewModel.inputs.searchForAthletesTriggered.onNext(query)
        }
        
        tableView.reloadData()
    }
}

// MARK: - IBOutlets

extension FindFriendsViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text, !searchText.isEmpty else { return }
        
        searchForAthletesWith(query: searchText)
    }
}

extension FindFriendsViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        tableView.reloadData()
    }
}
