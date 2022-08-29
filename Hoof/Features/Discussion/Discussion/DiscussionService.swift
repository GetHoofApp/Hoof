//
//  DiscussionService.swift
//  Discussion
//
//  Created Sameh Mabrouk on 12/01/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public protocol DiscussionServicePerforming {
    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool>
	func commentOnPost(activityUserID: String, userId: String, activityId: String, comment: String) -> Single<Athlete?>
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?>
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool>
}

class DiscussionService: DiscussionServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    public init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
	func commentOnPost(activityUserID: String, userId: String, activityId: String, comment: String) -> Single<Athlete?> {
		return Single.create { observer in

			let db = Firestore.firestore()
			let uid = Auth.auth().currentUser?.uid ?? ""
			db.collection("users").document(uid).getDocument { documentSnapshot, error in
				if let error = error {
					observer(.error(error))
				} else {
					let newDocumentID = UUID().uuidString
					db.collection("activities")
						.document(activityUserID)
						.collection("userActivities")
						.document(activityId)
						.collection("comments")
						.document(newDocumentID).setData([
							"user_id": userId,
							"text": comment,
							"creator": documentSnapshot?.data() as Any
						], merge: true) { error in
							if let error = error {
								print("Error writing document: \(error)")
								observer(.error(error))
							} else {
								let athlete = Athlete(data: documentSnapshot?.data())
								observer(.success(athlete))
								print("Document successfully written!")
							}
						}
				}
			}

			return Disposables.create()
		}
	}

    func commentOnPost(userID: String, postID: String, message: String) -> Single<Bool> {
        return client.perform(mutation: CommentOnPostMutation(userId: userID, postId: postID, message: message))
            .map { $0.commentOnPost?.success != nil }
            .asSingle()
    }
    
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?> {
		return Single.create { observer in

			let db = Firestore.firestore()
			let newDocumentID = UUID().uuidString
			db.collection("activities")
				.document(postUserID)
				.collection("userActivities")
				.document(postID)
				.collection("likes")
				.document(newDocumentID).setData([
					"user_id": userId
				], merge: true) { error in
					if let error = error {
						print("Error writing document: \(error)")
						observer(.error(error))
					} else {
						observer(.success(newDocumentID))
						print("Document successfully written!")
					}
				}

			return Disposables.create()
		}
	}

	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool> {
		return Single.create { observer in

			let db = Firestore.firestore()
			db.collection("activities")
				.document(userID)
				.collection("userActivities")
				.document(postID)
				.collection("likes")
				.document(likeId)
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
}
