//
//  FindFriendsService.swift
//  FindFriends
//
//  Created Sameh Mabrouk on 24/02/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core
import FirebaseCore
import FirebaseFirestore

public protocol FindFriendsServicePerforming {
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]>
	func followUser(userID: String, userToFollow: User) -> Single<Bool> 
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool>
    func searchUsers(query: String) -> Single<[User?]>
	func followAll(userID: String, usersToFollow: [User]) -> Single<Bool>
	func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool> 
}

class FindFriendsService: FindFriendsServicePerforming {
    
    private let client: GraphQLClientProtocol
    private let db = Firestore.firestore()

    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func fetchSuggestedAthletes(userID: Int) -> Single<[User?]> {
		return Single.create { observer in

			let db = Firestore.firestore()
			db.collection("users").getDocuments() { (querySnapshot, error) in
				if let error = error {
					print("Error getting documents: \(error)")
					observer(.error(error))
				} else {
					for document in querySnapshot!.documents {
						print("\(document.documentID) => \(document.data())")

					}

					let users = querySnapshot?.documents.compactMap {
						return User(data: $0.data())
					}

					observer(.success(users ?? []))
				}
			}
			return Disposables.create()
		}
    }
    
    func followUser(userID: String, userToFollow: User) -> Single<Bool> {
		return Single.create { observer in

			let db = Firestore.firestore()
			db.collection("following")
				.document(userID)
				.collection("userFollowing")
				.document(userToFollow.id)
				.setData([
					"user_id": userToFollow.id,
					"first_name": userToFollow.firstName,
					"last_name": userToFollow.lastName,
				  ]) { error in
					  if let error = error {
						  print("Error writing document: \(error)")
						  observer(.error(error))
					  } else {
						  observer(.success(true))
						  print("Document successfully written!")
					  }
				  }

			return Disposables.create()
		}
    }
    
    func unfollowUser(userID: String, userToUnfollowID: String) -> Single<Bool> {
		return Single.create { observer in

			let db = Firestore.firestore()
			db.collection("following")
				.document(userID)
				.collection("userFollowing")
				.document(userToUnfollowID)
				.delete() { error in
					  if let error = error {
						  print("Error writing document: \(error)")
						  observer(.error(error))
					  } else {
						  observer(.success(true))
						  print("Document successfully written!")
					  }
				  }

			return Disposables.create()
		}
    }
    
    func searchUsers(query: String) -> Single<[User?]> {
        return client.fetch(query: SearchUsersQuery(query: query))
            .map {
                $0.searchUsers?.compactMap {
                    return User(data: $0)
                } ?? []
            }.asSingle()
    }
    
    func followAll(userID: String, usersToFollow: [User]) -> Single<Bool> {
		return Single.create { observer in
			usersToFollow.forEach { userToFollow in
				let db = Firestore.firestore()
				db.collection("following")
					.document(userID)
					.collection("userFollowing")
					.document(userToFollow.id)
					.setData([
						"user_id": userToFollow.id,
						"first_name": userToFollow.firstName,
						"last_name": userToFollow.lastName,
					]) { error in
						if let error = error {
							print("Error writing document: \(error)")
							observer(.error(error))
						} else {
							observer(.success(true))
							print("Document successfully written!")
						}
					}
			}

			return Disposables.create()
		}
    }
    
    func unfollowAll(userID: String, usersIdsToUnfollow: [String]) -> Single<Bool> {
		return Single.create { observer in
			usersIdsToUnfollow.forEach { userIDToUnfollow in
				let db = Firestore.firestore()
				db.collection("following")
					.document(userID)
					.collection("userFollowing")
					.document(userIDToUnfollow)
					.delete() { error in
						if let error = error {
							print("Error writing document: \(error)")
							observer(.error(error))
						} else {
							observer(.success(true))
							print("Document successfully written!")
						}
					}
			}

			return Disposables.create()
		}
    }
}
