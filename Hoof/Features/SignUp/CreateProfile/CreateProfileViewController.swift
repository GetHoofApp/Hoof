//
//  CreateProfileViewController.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class CreateProfileViewController: ViewController<CreateProfileViewModel> {
    
    // MARK: - Properties

    private lazy var createProfileLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Create your profile"
        label.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createProfileSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Your profile is the home of  your activities and how friends find you on Hoof. "
        label.numberOfLines = 2
        label.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 18)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "First name"
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var firstNameFooterView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Password"
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.delegate = self
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var lastNameFooterView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false

        return view
    }()
    
    private lazy var genderLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Gender"
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 13)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var genderSelectorView: SelectionView = {
        let view = SelectionView(frame: .zero)
        view.selectionType = .radio
        view.delegate = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var continueButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Continue", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
        button.setTitleColor(UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private var selectedGender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
        
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        setupObservers()
        
        genderSelectorView.items = [SelectorItem(title: "Male"), SelectorItem(title: "Female"), SelectorItem(title: "Other")]
        
        view.backgroundColor = .white
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            createProfileLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
            createProfileLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            createProfileLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90),
            
            createProfileSubtitleLabel.topAnchor.constraint(equalTo: createProfileLabel.bottomAnchor, constant: 20),
            createProfileSubtitleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            createProfileSubtitleLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            firstNameLabel.topAnchor.constraint(equalTo: createProfileSubtitleLabel.bottomAnchor, constant: 40),
            firstNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 20),
            firstNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            firstNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            firstNameFooterView.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 1),
            firstNameFooterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            firstNameFooterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            firstNameFooterView.heightAnchor.constraint(equalToConstant: 1),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameFooterView.bottomAnchor, constant: 20),
            lastNameLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 20),
            lastNameTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            lastNameTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            
            lastNameFooterView.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 1),
            lastNameFooterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            lastNameFooterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            lastNameFooterView.heightAnchor.constraint(equalToConstant: 1),

            genderLabel.topAnchor.constraint(equalTo: lastNameFooterView.bottomAnchor, constant: 20),
            genderLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            
            genderSelectorView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderSelectorView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8),
            genderSelectorView.rightAnchor.constraint(equalTo: view.rightAnchor),
            genderSelectorView.heightAnchor.constraint(equalToConstant: 150),
            
            continueButton.topAnchor.constraint(equalTo: genderSelectorView.bottomAnchor, constant: 19),
            continueButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 39),
        ])
    }
    
    func setupSubviews() {
        view.addSubview(createProfileLabel)
        view.addSubview(createProfileSubtitleLabel)
        view.addSubview(firstNameLabel)
        view.addSubview(firstNameTextField)
        view.addSubview(firstNameFooterView)
        view.addSubview(lastNameLabel)
        view.addSubview(lastNameTextField)
        view.addSubview(lastNameFooterView)
        view.addSubview(genderLabel)
        view.addSubview(genderSelectorView)
        view.addSubview(continueButton)
    }
    
    private func setupNavogationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
    }
    
    override func setupObservers() {}
    
    @objc func signUpButtonTapped() {
        viewModel.inputs.continueButtonTapped.onNext((firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", gender: selectedGender ?? ""))
    }
}

// MARK: - Helpers

extension CreateProfileViewController {
    
    func updateContinueButtonUI() {
        if selectedGender != nil && !(firstNameTextField.text?.isEmpty ?? false) && !(lastNameTextField.text?.isEmpty ?? false) {
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.backgroundColor = .black
        } else {
            continueButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
            continueButton.setTitleColor(UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0), for: .normal)
        }
        
    }
}

// MARK: - SelectionViewDelegate

extension CreateProfileViewController: SelectionViewDelegate {
    
    func selectionMaxLimitReached(_ selectionView: SelectionView) {}
    
    func didSelectItem(_ selectItem: SelectorItem) {
        selectedGender = selectItem.isSelected ? selectItem.title : nil
            
        updateContinueButtonUI()
    }
}

// MARK: - UITextFieldDelegate

extension CreateProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        updateContinueButtonUI()
        view.endEditing(true)
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateContinueButtonUI()
    }
}
