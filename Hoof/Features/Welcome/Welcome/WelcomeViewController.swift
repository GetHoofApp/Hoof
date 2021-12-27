//
//  WelcomeViewController.swift
//  Welcome
//
//  Created Sameh Mabrouk on 26/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core

class WelcomeViewController: ViewController<WelcomeViewModel> {

    // MARK: - Properties

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "Hoof-logo-transparent")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.image = #imageLiteral(resourceName: "welcome-bg")
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Welcome"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "You are only a few steps a way from Hoof."
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Already have an account?"
        label.textColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Login In", for: .normal)
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.backgroundColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "New to Hoof? Sign up."
        label.textColor = UIColor(red: 65/255, green: 65/255, blue: 65/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("Sign up with Email", for: .normal)
        button.layer.cornerRadius = 5
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
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
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.leftAnchor.constraint(equalTo: view.leftAnchor),
            imageView.rightAnchor.constraint(equalTo: view.rightAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 454),
            
            subtitleLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -19),
            subtitleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            subtitleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
            
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -18),
            titleLabel.leftAnchor.constraint(equalTo: imageView.leftAnchor, constant: 16),
            titleLabel.rightAnchor.constraint(equalTo: imageView.rightAnchor),
                        
            logoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 44),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalToConstant: 173),
            logoImageView.heightAnchor.constraint(equalToConstant: 54),
            
            loginLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 16),
            loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            loginButton.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 16),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            loginButton.heightAnchor.constraint(equalToConstant: 39),
            
            signUpLabel.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 30),
            signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            signUpButton.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 16),
            signUpButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16),
            signUpButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16),
            signUpButton.heightAnchor.constraint(equalToConstant: 39),
        ])
    }
    
    func setupSubviews() {
        imageView.addSubview(subtitleLabel)
        imageView.addSubview(titleLabel)
        view.addSubview(imageView)
        view.addSubview(logoImageView)
        view.addSubview(loginLabel)
        view.addSubview(loginButton)
        view.addSubview(signUpLabel)
        view.addSubview(signUpButton)
    }
    
    private func setupNavogationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupObservers() {}
}
