//
//  ProfileService.swift
//  Profile
//
//  Created Sameh Mabrouk on 15/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public protocol ProfileServicePerforming {
	func fetchAthleteProfile() -> Single<Athlete?>
}

class ProfileService: ProfileServicePerforming {

	func fetchAthleteProfile() -> Single<Athlete?> {
		return Single.create { observer in
			let uid = Auth.auth().currentUser?.uid ?? ""
			let db = Firestore.firestore()
			db.collection("users").document(uid).getDocument { documentSnapshot, error in
				if let error = error {
					observer(.error(error))
				} else {
					let athlete = Athlete(data: documentSnapshot?.data())
					observer(.success(athlete))
				}
			}
			return Disposables.create()
		}

	}
}
