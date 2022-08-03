//
//  UpdateProfileService.swift
//  UpdateProfile
//
//  Created Sameh Mabrouk on 09/03/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core
import FirebaseCore
import FirebaseFirestore
import FirebaseStorage
import FirebaseAuth

public protocol UpdateProfileServicePerforming {
	func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage?, userID: String) -> Single<Bool>
}

class UpdateProfileService: UpdateProfileServicePerforming {

	private let firebaseStorage: Storage

	init(firebaseStorage: Storage) {
		self.firebaseStorage = firebaseStorage
	}

	func updateProfile(firstName: String, lastName: String, gender: String, logo: UIImage?, userID: String) -> Single<Bool> {

		return Single.create { observer in
			let uid = Auth.auth().currentUser?.uid ?? ""
			let storageRef = self.firebaseStorage.reference().child("\(uid).png")
			if let logo = logo, let uploadData = logo.jpegData(compressionQuality: 0.5) {
				storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
					if error != nil {
						observer(.success(false))
					} else {
						storageRef.downloadURL(completion: { (url, error) in
							print(url?.absoluteString)
							// update user data
							let db = Firestore.firestore()
							db.collection("users").document(uid).updateData([
								"first_name": firstName,
								"last_name": lastName,
								"gender": gender,
								"imageUrl": url?.absoluteString ?? ""
							]) { error in
								if let error = error {
									print("[Firestore Error]: \(String(describing: error))")
									observer(.error(error))
								} else {
									observer(.success(true))
									print("Document added with ID")
								}
							}
						})
					}
				}
			}
			return Disposables.create()
		}
	}
}
