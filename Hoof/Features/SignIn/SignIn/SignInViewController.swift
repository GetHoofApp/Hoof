//
//  SignInViewController.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class SignInViewController: ViewController<SignInViewModel> {

	// MARK: - Properties

	private lazy var signupLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Sign in with email"
		label.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1.0)
		label.font = UIFont.boldSystemFont(ofSize: 30)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var emailLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Email"
		label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
		label.font = UIFont.systemFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var emailTextField: UITextField = {
		let textField = UITextField(frame: .zero)
		textField.delegate = self
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()

	private lazy var emailFooterView: UIView = {
		let view = UIView(frame: .zero)
		view.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	private lazy var passwordLabel: UILabel = {
		let label = UILabel(frame: .zero)
		label.text = "Password"
		label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
		label.font = UIFont.systemFont(ofSize: 13)
		label.translatesAutoresizingMaskIntoConstraints = false
		return label
	}()

	private lazy var passwordTextField: UITextField = {
		let textField = UITextField(frame: .zero)
		textField.isSecureTextEntry = true
		textField.delegate = self
		textField.translatesAutoresizingMaskIntoConstraints = false
		return textField
	}()

	private lazy var passwordFooterView: UIView = {
		let view = UIView(frame: .zero)
		view.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
		view.translatesAutoresizingMaskIntoConstraints = false

		return view
	}()

	private lazy var signInButton: UIButton = {
		let button = UIButton(frame: .zero)
		button.setTitle("Log In", for: .normal)
		button.layer.cornerRadius = 5
		button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
		button.backgroundColor = .black
		button.translatesAutoresizingMaskIntoConstraints = false
		button.addTarget(self, action: #selector(signUpButtonTapped), for: .touchUpInside)
		return button
	}()

	override func viewDidLoad() {
		super.viewDidLoad()

		setupUI()
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)

		navigationController?.setNavigationBarHidden(false, animated: animated)
	}

	// MARK: - setupUI

	override func setupUI() {
		setupSubviews()
		setupConstraints()
		setupNavogationBar()
		setupObservers()

		view.backgroundColor = .white

		self.emailTextField.becomeFirstResponder()
	}

	override func setupConstraints() {
		NSLayoutConstraint.activate([
			signupLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
			signupLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			signupLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -90),

			emailLabel.topAnchor.constraint(equalTo: signupLabel.bottomAnchor, constant: 30),
			emailLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

			emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 20),
			emailTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			emailTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

			emailFooterView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 1),
			emailFooterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			emailFooterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			emailFooterView.heightAnchor.constraint(equalToConstant: 1),

			passwordLabel.topAnchor.constraint(equalTo: emailFooterView.bottomAnchor, constant: 20),
			passwordLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),

			passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 20),
			passwordTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			passwordTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),

			passwordFooterView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 1),
			passwordFooterView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			passwordFooterView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			passwordFooterView.heightAnchor.constraint(equalToConstant: 1),

			signInButton.topAnchor.constraint(equalTo: passwordFooterView.bottomAnchor, constant: 19),
			signInButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
			signInButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
			signInButton.heightAnchor.constraint(equalToConstant: 39),
		])
	}

	func setupSubviews() {
		view.addSubview(signupLabel)
		view.addSubview(emailLabel)
		view.addSubview(emailTextField)
		view.addSubview(emailFooterView)
		view.addSubview(passwordLabel)
		view.addSubview(passwordTextField)
		view.addSubview(passwordFooterView)
		view.addSubview(signInButton)
	}

	private func setupNavogationBar() {
		navigationController?.navigationBar.prefersLargeTitles = false
		navigationController?.navigationBar.barTintColor = .white
		navigationController?.navigationBar.tintColor = .black
	}

	override func setupObservers() {}

	@objc func signUpButtonTapped() {
		viewModel.inputs.signInButtonTapped.onNext((email: emailTextField.text ?? "", password: passwordTextField.text ?? ""))
	}
}

// MARK: - UITextFieldDelegate

extension SignInViewController: UITextFieldDelegate {

	func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		if textField == emailTextField && (passwordTextField.text?.isEmpty ?? false) {
			emailTextField.resignFirstResponder()
			passwordTextField.becomeFirstResponder()
		}

		if !(emailTextField.text?.isEmpty ?? false) && !(passwordTextField.text?.isEmpty ?? false) {
			view.endEditing(true)
		}

		return false
	}
}
