//
//  CreateProfileService.swift
//  SignUp
//
//  Created Sameh Mabrouk on 29/12/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public protocol CreateProfileServicePerforming {
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String>
	func createUserProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String?>
}

class CreateProfileService: CreateProfileServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func createProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String> {
        return client.perform(mutation: CreateUserMutation(firstName: firstName, lastName: lastName, password: password, email: email, gender: gender))
            .map {
                "\(String(describing: $0.createUser?.id))" 
            }.asSingle()
    }

	func createUserProfile(firstName: String, lastName: String, email: String, password: String, gender: String) -> Single<String?> {
		// Create user through Firebase Auth

		return Single.create { observer in
			Auth.auth().createUser(withEmail: email, password: password) { authResult, error in

				// Persist created user from Firebase Auth to Firebase database
				if let email = authResult?.user.email, let uid = authResult?.user.uid {
					let db = Firestore.firestore()
					var ref: DocumentReference? = nil
					db.collection("users").document(uid).setData([
						"user_id": uid,
						"email": email,
						"first_name": firstName,
						"last_name": lastName,
						"gender": gender
					]) { error in
						if let error = error {
							print("[Firestore Error]: \(String(describing: error))")
							observer(.error(error))
						} else {
							observer(.success(authResult?.user.uid))
							print("Document added with ID")
						}
					}
					
//					ref = db.collection("users").document(uid).setData([
//						"email": email,
//						"first_name": firstName,
//						"last_name": lastName,
//						"gender": gender
//					]) { error in
//						if let error = error {
//							print("[Firestore Error]: \(String(describing: error))")
//							observer(.error(error))
//						} else {
//							observer(.success(authResult?.user.uid))
//							print("Document added with ID: \(String(describing: ref?.documentID))")
//						}
//					}
				}
			}

			return Disposables.create()
		}
	}
}
