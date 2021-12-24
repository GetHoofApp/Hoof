//
//  CreateChallengeViewController.swift
//  CreateChallenge
//
//  Created Sameh Mabrouk on 24/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class CreateChallengeViewController: ViewController<CreateChallengeViewModel> {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(withType: ChallengeCell.self)
        tableView.register(TableViewHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewHeader.self))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none

        return tableView
    }()
    
    let challenges: [Challenge] = [Challenge(name: "Fastest Sprint", description: "Record the fastest sprint over a set distance during a football match.", icon: #imageLiteral(resourceName: "fast-player")),
                                   Challenge(name: "Longest Distance", description: "Record the most distance during one football match. ", icon: #imageLiteral(resourceName: "fast-player")),
                                   Challenge(name: "Top Scorer", description: "Score X number of goals during a set of time.", icon: #imageLiteral(resourceName: "fast-player")),
                                   Challenge(name: "Best Position", description: "Best looking heatmap for a specific position(stricker, defense, play maker, etc...)", icon: #imageLiteral(resourceName: "fast-player"))
    ]
        
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
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0),
        ])
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupNavogationBar() {
        title = "Create a challenge"
    }
    
    override func setupObservers() {}
}

// MARK: - UITableViewDataSource

extension CreateChallengeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(forType: ChallengeCell.self)
        let challenge = challenges[indexPath.row]
        cell.configure(title: challenge.name, subtitle: challenge.description, icon: challenge.icon)
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
            String(describing: TableViewHeader.self)) as? TableViewHeader else { return nil }
        
        return view
    }
}

// MARK: - UITableViewDataSource

extension CreateChallengeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
