//
//  ActivitiesViewController.swift
//  Activities
//
//  Created Sameh Mabrouk on 03/08/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class ActivitiesViewController: ViewController<ActivitiesViewModel> {

	// MARK: - Properties

	private lazy var tableView: UITableView = {
		let tableView = UITableView(frame: .zero)
		tableView.estimatedRowHeight = 200
		tableView.rowHeight = UITableView.automaticDimension
		tableView.registerCell(withType: ActivityCell.self)
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

	override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}
