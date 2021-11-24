//
//  HomeViewController.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class HomeViewController: ViewController<HomeViewModel> {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(withType: ActivityCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private let activities: [ActivityItem] = [
        ActivityItem(name: "Jessica", date: "OCTOBER 26, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND", userPhoto: #imageLiteral(resourceName: "user1"), activityName: "Sunday Match ", distance: "30 KM", pace: "5 /Km", activityImage: #imageLiteral(resourceName: "user1")),
        ActivityItem(name: "Chris", date: "NOVEMBER 26, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND", userPhoto: #imageLiteral(resourceName: "player5"), activityName: "Staurday Match ", distance: "50 KM", pace: "5 /Km", activityImage: #imageLiteral(resourceName: "user1")),
        ActivityItem(name: "Ronald", date: "NOVEMBER 30, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND", userPhoto: #imageLiteral(resourceName: "player1"), activityName: "Evening Game ", distance: "40 KM", pace: "5 /Km", activityImage: #imageLiteral(resourceName: "user1")),
        ActivityItem(name: "Jack", date: "NOVEMBER 30, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND", userPhoto: #imageLiteral(resourceName: "player4"), activityName: "Mid-week Match", distance: "45 KM", pace: "5 /Km", activityImage: #imageLiteral(resourceName: "user1")),
        ActivityItem(name: "Ibrahim", date: "NOVEMBER 30, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND", userPhoto: #imageLiteral(resourceName: "player3"), activityName: "Wednesday Match", distance: "60 KM", pace: "5 /Km", activityImage: #imageLiteral(resourceName: "user1")),
    ]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        setupObservers()
        
        view.backgroundColor = .white
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
        
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupObservers() {}
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        activities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(forType: ActivityCell.self)
        let activity = activities[indexPath.row]
        cell.configure(name: activity.name, userImage: activity.userPhoto, date: activity.date, activityName: activity.activityName, distance: activity.distance, pace: activity.pace)
        return cell
    }
}

// MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
