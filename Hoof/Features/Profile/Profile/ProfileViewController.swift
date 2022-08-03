//
//  ProfileViewController.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import RxCocoa
import RxSwift

class ProfileViewController: ViewController<ProfileViewModel> {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCells(withTypes: [AthleteDetailsCell.self, AthleteActivitiesCell.self])
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

	private var athlete: Athlete!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
		
		viewModel.inputs.viewState.onNext(.loaded)
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
        
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 243/255, alpha: 1.0)
//        tableView.tableFooterView = UIView()
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
        title = "You"
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func setupObservers() {
		viewModel.outputs.viewData
			.observeOn(MainScheduler.asyncInstance)
			.subscribe(onNext: { [weak self] viewData in
				guard let self = self else { return }

				self.athlete = viewData.athlete
				self.tableView.reloadData()
			}).disposed(by: viewModel.disposeBag)
	}
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		guard athlete != nil else { return 0 }

        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
		guard athlete != nil else { return 0 }

		return 2
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 10 : 1
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
//    // Set the spacing between sections
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return section == 0 ? 0 : 20
//    }
//
//    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.getCell(forType: AthleteDetailsCell.self)
            cell.editButtonTap
                .subscribe(onNext: { [weak self] in
                    guard let self = self else { return }
                    
					self.viewModel.inputs.editProfileButtonTapped.onNext((profilePhotoURL: self.athlete.imageUrl, firstName: self.athlete.first_name, lastName: self.athlete.last_name, gender: self.athlete.gender))
                })
                .disposed(by: viewModel.disposeBag)
			cell.configure(userImageURL: athlete.imageUrl, userName: athlete.first_name + " " + athlete.last_name, userLocation: "AMSTERDAM, NORTH HOLAND", followers: "150", following: "100")
            return cell
        } else {
//            let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")
//            var content = cell.defaultContentConfiguration()
//
//            content.image = UIImage(named: "soccer")
//            content.text = "Activities"
//            content.secondaryText = "January 1, 2022"
//
//
//            cell.contentConfiguration = content
//            cell.accessoryType = .disclosureIndicator
            
            let cell = tableView.getCell(forType: AthleteActivitiesCell.self)
            cell.configure(title: "Activities", subtitle: "January 1, 2022")
            return cell
        }        
    }
}

// MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ProfileViewController {

	struct ViewData {
		let athlete: Athlete
	}
}
