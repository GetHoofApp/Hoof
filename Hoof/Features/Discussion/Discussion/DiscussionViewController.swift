//
//  DiscussionViewController.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import GoogleMaps
import RxSwift

class DiscussionViewController: ViewController<DiscussionViewModel>, KeyboardObserving {
    
    // MARK: - Properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCells(withTypes: [MapCell.self, ActivityDetailsCell.self, CommentCell.self])
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 249/255, alpha: 1.0)
        tableView.register(TableViewSectionHeader.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewSectionHeader.self))
        tableView.register(TableViewSectionFooter.self, forHeaderFooterViewReuseIdentifier: String(describing: TableViewSectionFooter.self))
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 224/255, green: 224/255, blue: 224/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    private lazy var commentView: UIView = {
//        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
//
//    private lazy var textField: UITextField = {
//        let textField = UITextField(frame: .zero)
//        textField.delegate = self
//        textField.addTarget(self, action: #selector(textFieldDidChange), for: UIControl.Event.editingChanged)
//        textField.placeholder = "Add a comment"
//        textField.translatesAutoresizingMaskIntoConstraints = false
//        return textField
//    }()
    
    private lazy var commentView: MessageInputView = {
        let messageView = MessageInputView(frame: .zero)
        messageView.placeholder = "Add a comment"
        messageView.delegate = self
        messageView.translatesAutoresizingMaskIntoConstraints = false
        return messageView
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Send", for: .normal)
        button.setTitleColor(UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        button.addTarget(self, action: #selector(self.selectButtonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var comments: [AthleteActivityComment]?
    
    @objc func selectButtonAction(_ button: UIButton) {
		viewModel.inputs.sendButtonTapped.onNext((viewModel.activity.id, viewModel.activity.user_id, commentView.textView?.text ?? ""))
        commentView.textView?.text = nil
    }
    
    public var commentViewBottomConstraint: NSLayoutConstraint!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GMSServices.provideAPIKey("AIzaSyAQEtHPhRoMo1EoXu8FS_459wrEtyEBfSo")
        
        comments = viewModel.activity.comments
        
        setupUI()
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        setupObservers()
        
//        // Initialize Swipe Gesture Recognizer
//        let swipeGestureRecognizerDown = UISwipeGestureRecognizer(target: self, action: #selector(didSwipe(_:)))
//
//        // Configure Swipe Gesture Recognizer
//        swipeGestureRecognizerDown.direction = .down
//
//        // Add Swipe Gesture Recognizer
//        commentView.addGestureRecognizer(swipeGestureRecognizerDown)
        
        view.backgroundColor = .white
    }
    
    @objc private func didSwipe(_ sender: UISwipeGestureRecognizer) {
        view.endEditing(true)
    }
    
    override func setupConstraints() {
        commentViewBottomConstraint = commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        commentViewBottomConstraint.priority = UILayoutPriority(rawValue: 300)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: commentView.topAnchor),
            
            commentView.leftAnchor.constraint(equalTo: view.leftAnchor),
            commentView.rightAnchor.constraint(equalTo: view.rightAnchor),
            //            commentView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            commentViewBottomConstraint,
            commentView.heightAnchor.constraint(equalToConstant: 45),
            
            divider.topAnchor.constraint(equalTo: commentView.topAnchor),
            divider.leftAnchor.constraint(equalTo: commentView.leftAnchor),
            divider.rightAnchor.constraint(equalTo: commentView.rightAnchor),
            divider.heightAnchor.constraint(equalToConstant: 0.2),
            
//            textField.leftAnchor.constraint(equalTo: commentView.leftAnchor, constant: 16),
//            textField.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 12),
//            textField.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -12),
//            textField.rightAnchor.constraint(equalTo: sendButton.leftAnchor, constant: 5),
//
            //            sendButton.leftAnchor.constraint(equalTo: textField.rightAnchor, constant: 5),
            sendButton.rightAnchor.constraint(equalTo: commentView.rightAnchor, constant: -16),
            sendButton.topAnchor.constraint(equalTo: commentView.topAnchor, constant: 16),
            sendButton.bottomAnchor.constraint(equalTo: commentView.bottomAnchor, constant: -16),
        ])
    }
    
    public override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        if parent == nil {
			viewModel.inputs.dismiss.onNext(viewModel.activity)
        }
    }
    
    func setupSubviews() {
        view.addSubview(tableView)
        commentView.addSubview(divider)
//        commentView.addSubview(textField)
        commentView.addSubview(sendButton)
        view.addSubview(commentView)
    }
    
    private func setupNavogationBar() {
        title = "Discussion"
        
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupObservers() {
        keyboardHeight()
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] keyboardHeight in
                guard let self = self else { return }
                
                if keyboardHeight <= 0 {
                    self.commentViewBottomConstraint.constant = 0
                } else {
                    self.commentViewBottomConstraint.constant = -250
                    //                    self.tableView.scrollToBottom(animated: true)
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
						let indexPath = IndexPath(row: 0, section: ((self.viewModel.activity.comments.count) + 2) - 1)
                        self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                    })
                }
                self.view.setNeedsLayout()
            }).disposed(by: viewModel.disposeBag)
        
        viewModel.outputs.updateView
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] comment in
                guard let self = self else { return }

                self.comments?.append(comment)
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.1, execute: {
                    let indexPath = IndexPath(row: 0, section: ((self.viewModel.activity.comments.count) + 2) - 1)
                    self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                })
            }).disposed(by: viewModel.disposeBag)

		viewModel.outputs.refreshView
			.observeOn(MainScheduler.asyncInstance)
			.subscribe(onNext: { [weak self] comment in
				guard let self = self else { return }

				self.tableView.reloadData()
			}).disposed(by: viewModel.disposeBag)
    }
}

// MARK: - UITableViewDataSource

extension DiscussionViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return (comments?.count ?? 0) + 2
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 || section == 1 || section == 2 ? 0 : 0.2
    }
    
//    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
//                                                                    String(describing: TableViewSectionHeader.self)) as? TableViewSectionHeader else { return nil }
//
//        return view
//    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
		return section == ((viewModel.activity.comments.count) + 2) - 2 ? 0.2 : 0
//		return 0
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier:
                                                                    String(describing: TableViewSectionHeader.self)) as? TableViewSectionHeader else { return nil }
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.getCell(forType: MapCell.self)
//            cell.configure(with: viewModel.activity.coordinates)
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.getCell(forType: ActivityDetailsCell.self)
            cell.likeButtonTap
                .subscribe(onNext: { [weak self] in
					guard let self = self,
							let userId = UserDefaults.standard.value(forKey: "UserID") as? String else { return }

					let like = cell.activity.likes.first { $0.creator?.user_id == userId }
					self.viewModel.inputs.likeButtonTapped.onNext((self.viewModel.activity, cell.activity.user_id, cell.activity.id, like?.id, cell.activity.isActivityLiked(userId: userId)))
                })
                .disposed(by: cell.disposeBag)
            cell.configure(with: viewModel.activity)
            return cell
        } else {
            let cell = tableView.getCell(forType: CommentCell.self)
            if let comments = self.comments {
                cell.configure(with: comments[indexPath.section-2])
            }
            return cell
        }
    }
}

// MARK: - UITableViewDelegate

extension DiscussionViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - MessageInputViewDelegate

extension DiscussionViewController: MessageInputViewDelegate {
    
    func inputView(textView: UITextView, shouldChangeTextInRange: NSRange, replacementText: String) -> Bool {
        return true
    }
    
    func inputViewDidBeginEditing(textView: UITextView) {}
    
    func inputViewShouldBeginEditing(textView: UITextView) -> Bool {
        return true
    }
    
    func inputViewDidTapButton(button: UIButton) {}
    
    func inputViewDidChange(textView: UITextView) {
        if !(textView.text ?? "").isEmpty {
            sendButton.setTitleColor(UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0) , for: .normal)
            sendButton.isEnabled = true
        } else {
            sendButton.setTitleColor(UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0), for: .normal)
            sendButton.isEnabled = false
            
            commentView.placeholder = "Add a comment"
        }
    }
}
