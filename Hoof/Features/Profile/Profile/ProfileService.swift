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
			var followersCount = 0

			db.collection("users").document(uid).getDocument { documentSnapshot, error in
				if let error = error {
					observer(.error(error))
				} else {
					db.collection("following").getDocuments { followingQuerySnapshot, error in
						if let error = error {
							print("Error getting documents: \(error)")
							observer(.error(error))
						} else {
							var newDocs = followingQuerySnapshot!.documents.map {
								$0.documentID
							}
							newDocs.append(uid)

							for doc in newDocs {
								db.collection("following").document(doc).collection("userFollowing").getDocuments { querySnapshot, error in
									for document in querySnapshot!.documents {
										print("\(document.documentID) => \(document.data())")
										if document.documentID == uid {
											followersCount += 1
										}

										if doc == newDocs.last {
											db.collection("following").document(uid).collection("userFollowing").getDocuments { querySnapshot, error in
												if let error = error {
													print("Error getting documents: \(error)")
													observer(.error(error))
												} else {
													for document in querySnapshot!.documents {
														print("\(document.documentID) => \(document.data())")
													}

													var athlete = Athlete(data: documentSnapshot?.data())
													athlete?.followingCount = querySnapshot?.documents.count
													athlete?.followersCount = followersCount
													observer(.success(athlete))
												}
											}
										}
									}
								}
							}
						}
					}
				}
			}
			return Disposables.create()
		}
	}
}
