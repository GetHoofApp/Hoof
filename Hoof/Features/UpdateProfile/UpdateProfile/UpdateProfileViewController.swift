//
//  UpdateProfileViewController.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import RxSwift
import RxCocoa
import Kingfisher

class UpdateProfileViewController: ViewController<UpdateProfileViewModel>, UIScrollViewDelegate {
    
    // MARK: - Properties

    private lazy var createProfileLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Edit your profile"
        label.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1.0)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var createProfileSubtitleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "Your profile is the home of  your activities and how friends find you on Hoof."
        label.numberOfLines = 2
        label.textColor = UIColor(red: 17/255, green: 17/255, blue: 17/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView(frame: .zero)
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.gray.cgColor
        imageView.layer.masksToBounds = false
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()

    private lazy var profileButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.layer.cornerRadius = 25
        button.addTarget(self, action: #selector(selectImageButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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
        label.text = "Last Name"
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
		button.isUserInteractionEnabled = true
        return button
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.size.width, height: 600)
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private var selectedGender: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        viewModel.inputs.viewState.onNext(.loaded)
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
        
        genderSelectorView.items = [SelectorItem(title: "Male"), SelectorItem(title: "Female"), SelectorItem(title: "Other")]
        
        view.backgroundColor = .white
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 8.0),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 29),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -8.0),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -8.0),
            
            contentView.heightAnchor.constraint(equalToConstant: 800),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 8.0),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -8.0),

            createProfileLabel.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 29),
            createProfileLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            createProfileLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -90),
            
            createProfileSubtitleLabel.topAnchor.constraint(equalTo: createProfileLabel.bottomAnchor, constant: 20),
            createProfileSubtitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            createProfileSubtitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            profileImageView.topAnchor.constraint(equalTo: createProfileSubtitleLabel.bottomAnchor, constant: 20),
            profileImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
            
            profileButton.topAnchor.constraint(equalTo: createProfileSubtitleLabel.bottomAnchor, constant: 20),
            profileButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 100),
            profileButton.heightAnchor.constraint(equalToConstant: 100),
            
            firstNameLabel.topAnchor.constraint(equalTo: profileButton.bottomAnchor, constant: 40),
            firstNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            firstNameTextField.topAnchor.constraint(equalTo: firstNameLabel.bottomAnchor, constant: 20),
            firstNameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            firstNameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            firstNameFooterView.topAnchor.constraint(equalTo: firstNameTextField.bottomAnchor, constant: 1),
            firstNameFooterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            firstNameFooterView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            firstNameFooterView.heightAnchor.constraint(equalToConstant: 1),
            
            lastNameLabel.topAnchor.constraint(equalTo: firstNameFooterView.bottomAnchor, constant: 20),
            lastNameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            lastNameTextField.topAnchor.constraint(equalTo: lastNameLabel.bottomAnchor, constant: 20),
            lastNameTextField.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            lastNameTextField.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            
            lastNameFooterView.topAnchor.constraint(equalTo: lastNameTextField.bottomAnchor, constant: 1),
            lastNameFooterView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            lastNameFooterView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            lastNameFooterView.heightAnchor.constraint(equalToConstant: 1),

            genderLabel.topAnchor.constraint(equalTo: lastNameFooterView.bottomAnchor, constant: 20),
            genderLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            
            genderSelectorView.topAnchor.constraint(equalTo: genderLabel.bottomAnchor, constant: 5),
            genderSelectorView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            genderSelectorView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            genderSelectorView.heightAnchor.constraint(equalToConstant: 150),
            
            continueButton.topAnchor.constraint(equalTo: genderSelectorView.bottomAnchor, constant: 19),
            continueButton.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            continueButton.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            continueButton.heightAnchor.constraint(equalToConstant: 39),
        ])
    }
    
    func setupSubviews() {
        view.addSubview(scrollView)
        
        contentView.addSubview(createProfileLabel)
        contentView.addSubview(createProfileSubtitleLabel)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileButton)
        
        contentView.addSubview(firstNameLabel)
        contentView.addSubview(firstNameTextField)
        contentView.addSubview(firstNameFooterView)
        contentView.addSubview(lastNameLabel)
        contentView.addSubview(lastNameTextField)
        contentView.addSubview(lastNameFooterView)
        contentView.addSubview(genderLabel)
        contentView.addSubview(genderSelectorView)
        contentView.addSubview(continueButton)
        
        scrollView.addSubview(contentView)
    }
    
    private func setupNavogationBar() {
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .black
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelButtonTapped))
    }
    
    override func setupObservers() {
        viewModel.outputs.viewData
            .observeOn(MainScheduler.asyncInstance)
            .subscribe(onNext: { [weak self] viewData in
                guard let self = self else { return }
                
                let placeholder = #imageLiteral(resourceName: "athlete-placeholder")
				if let userPhotoURL = URL(string: viewData.imageURL ?? "") {
                    let processor = RoundCornerImageProcessor(cornerRadius: 25, targetSize: CGSize(width: 50, height: 50))
                    self.profileImageView.kf.indicatorType = .activity
                    self.profileImageView.kf.setImage(
                        with: userPhotoURL,
                        placeholder: placeholder,
                        options: [
                            .processor(processor),
                            .scaleFactor(UIScreen.main.scale),
                            .transition(.fade(1)),
                            .cacheOriginalImage
                        ])
                } else {
                    self.profileImageView.image = placeholder
                }
                
                self.firstNameTextField.text = viewData.firstName
                self.lastNameTextField.text = viewData.lastName
                
            }).disposed(by: viewModel.disposeBag)
    }
    
    @objc func signUpButtonTapped() {
//		viewModel.inputs.continueButtonTapped.onNext((firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", gender: selectedGender ?? "", logo: profileImageView.image))
		viewModel.inputs.continueButtonTapped.onNext((firstName: firstNameTextField.text ?? "", lastName: lastNameTextField.text ?? "", gender: selectedGender ?? "", logo: profileImageView.image))
    }
    
    @objc func cancelButtonTapped() {
        viewModel.inputs.cancelButtonTapped.onNext(())
    }
    
    @objc func selectImageButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler: { _ in
              self.openCamera()
          }))
          
          alert.addAction(UIAlertAction(title: "Choose Photo", style: .default, handler: { _ in
              self.openGallary()
          }))
          
          alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
          
          //If you want work actionsheet on ipad then you have to use popoverPresentationController to present the actionsheet, otherwise app will crash in iPad
          switch UIDevice.current.userInterfaceIdiom {
          case .pad:
              alert.popoverPresentationController?.sourceView = sender
              alert.popoverPresentationController?.sourceRect = sender.bounds
              alert.popoverPresentationController?.permittedArrowDirections = .up
          default:
              break
          }
          
          self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - Helpers

extension UpdateProfileViewController {
    
    func updateContinueButtonUI() {
        if selectedGender != nil && !(firstNameTextField.text?.isEmpty ?? false) && !(lastNameTextField.text?.isEmpty ?? false) {
            continueButton.setTitleColor(.white, for: .normal)
            continueButton.backgroundColor = .black
        } else {
            continueButton.backgroundColor = UIColor(red: 223/255, green: 223/255, blue: 231/255, alpha: 1.0)
            continueButton.setTitleColor(UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0), for: .normal)
        }
    }
    
    //MARK: - Open the camera
    
     func openCamera(){
         if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera)){
             imagePicker.sourceType = UIImagePickerController.SourceType.camera
             //If you dont want to edit the photo then you can set allowsEditing to false
             imagePicker.allowsEditing = true
             imagePicker.delegate = self
             self.present(imagePicker, animated: true, completion: nil)
         }
         else{
             let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }
     }
     
     //MARK: - Choose image from camera roll
     
     func openGallary() {
         imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
         //If you dont want to edit the photo then you can set allowsEditing to false
         imagePicker.allowsEditing = true
         imagePicker.delegate = self
         self.present(imagePicker, animated: true, completion: nil)
     }
}

// MARK: - SelectionViewDelegate

extension UpdateProfileViewController: SelectionViewDelegate {
    
    func selectionMaxLimitReached(_ selectionView: SelectionView) {}
    
    func didSelectItem(_ selectItem: SelectorItem) {
        selectedGender = selectItem.isSelected ? selectItem.title : nil
            
        updateContinueButtonUI()
    }
}

// MARK: - UITextFieldDelegate

extension UpdateProfileViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == firstNameTextField && (lastNameTextField.text?.isEmpty ?? false) {
            firstNameTextField.resignFirstResponder()
            lastNameTextField.becomeFirstResponder()
        }
        
        if !(firstNameTextField.text?.isEmpty ?? false) && !(lastNameTextField.text?.isEmpty ?? false) {
            view.endEditing(true)
        }

        updateContinueButtonUI()
        return false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        updateContinueButtonUI()
    }
}

extension UpdateProfileViewController {
    
    struct ViewData {
        let imageURL: String?
        let firstName: String
        let lastName: String
        let gender: String?
    }
}

//MARK: - UIImagePickerControllerDelegate
extension UpdateProfileViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        /*
         Get the image from the info dictionary.
         If no need to edit the photo, use `UIImagePickerControllerOriginalImage`
         instead of `UIImagePickerControllerEditedImage`
         */
        if let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            profileImageView.image = editedImage
        }
        
        //Dismiss the UIImagePicker after selection
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}
