//
//  HomeService.swift
//  Home
//
//  Created Sameh Mabrouk on 08/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Core
import CodableGeoJSON
import FirebaseFunctions
import Alamofire
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

public protocol HomeServiceFetching {
    func fetchAthleteActivties(userID: Int) -> Single<[Activity?]>
	func fetchAthelteActivitiesTimeline(userID: String, lastVisibleUserId: String, limit: Int) -> Single<[AthleteActivity?]>
    func likePost(postUserID: String, userId: String, postID: String) -> Single<String?>
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool>
	func helloWorld()
}

public protocol HomeServicePerforming {
    func uploadActivity()
}

class HomeService: HomeServiceFetching {
    
    private let client: GraphQLClientProtocol
	private let session: SessionManager
    
	public init(client: GraphQLClientProtocol, session: SessionManager) {
        self.client = client
		self.session = session
    }

	func helloWorld() {
		lazy var functions = Functions.functions()
		functions.httpsCallable("hello_world").call { result, error in
			if let error = error as NSError? {
				if error.domain == FunctionsErrorDomain {
					let code = FunctionsErrorCode(rawValue: error.code)
					let message = error.localizedDescription
					let details = error.userInfo[FunctionsErrorDetailsKey]
				}
			}
		}
	}

	func fetchAthelteActivitiesTimeline(userID: String, lastVisibleUserId: String, limit: Int) -> Single<[AthleteActivity?]> {

//		return Single.create { observer in
//
//		lazy var functions = Functions.functions()
//
//			functions.httpsCallable("athlete_activities_timeline").call(["user_id": "WylSuRdHaSXXdYYHXU3kGKGvKEj2"]) { result, error in
//			 if let error = error as NSError? {
//				 if error.domain == FunctionsErrorDomain {
//					 let code = FunctionsErrorCode(rawValue: error.code)
//					 let message = error.localizedDescription
//					 let details = error.userInfo[FunctionsErrorDetailsKey]
//				 }
//				 print("fetchAthelteActivitiesTimeline [Firestore Error]: \(String(describing: error))")
//				 observer(.error(error))
//			 } else {
//				 print("[Firestore]: response")
//				 if let data = result?.data as? [String: Any] {
//					 print("[Firestore Response]:", data)
//				 }
//				 observer(.success([]))
//			 }
//		 }
//
//			return Disposables.create()
//		}

		return Single.create { [unowned self] observer in

			self.session.request(Router.fetchAthelteActivitiesTimeline(userID: userID, lastVisibleUserId: lastVisibleUserId, limit: limit)).responseJSON { response in
				switch response.result {
				case .success:
					if let data = response.data {
						do {
							let json = try JSONDecoder().decode([AthleteActivity].self, from: data)
							let activities = json
							observer(.success(activities))
						}
						catch {
							print("Error processing data \(error)")
							observer(.success([]))
						}
					}
				case  let .failure(error):
					print("Error\(String(describing: error))")
					observer(.error(error))
				}
			}

			return Disposables.create()
		}
	}
	
    func fetchAthleteActivties(userID: Int) -> Single<[Activity?]> {
        return client.fetch(query: PostsQuery(userId: userID))
            .map {
                $0.posts?.compactMap {
                    guard case .geometry(let geometry, _) = $0?.coordinates else {
                        return nil
                    }
                    
                    switch geometry {
                    case .multiLineString(let coordinates):
						let foundUserLike = $0?.likes?.first(where: { $0?.creator?.id == "7" }) != nil
						let likes = $0?.likes?.compactMap { Like(data: $0) }
                        let comments = $0?.comments?.compactMap { Comment(data: $0) }
                        
                        let distance = (($0?.distance ?? 0.0) / 1000).round(to: 2)
                        
                        var durationAsString = ""
                        if let duration = $0?.duration?.round(to: 2), duration > 0 {
                            let durationAsHour = duration / 3600
                            if durationAsHour > 1 {
                                durationAsString = "\(durationAsHour)"
                            }
                            
                            let durationAsMinutes = duration / 60
                            if durationAsMinutes > 0 {
                                if durationAsHour > 1 {
                                    durationAsString.append(contentsOf: ":")
                                }
                                durationAsString.append(contentsOf: "\(Int(durationAsMinutes))")
                            }

                            let durationAsSeconds = duration.truncatingRemainder(dividingBy: 60.0)
                            if durationAsSeconds > 0 {
                                if durationAsMinutes > 0 {
                                    durationAsString.append(contentsOf: ":")
                                }
                                durationAsString.append(contentsOf: "\(Int(durationAsSeconds))")
                            }
                        }
                        
                        var paceAsString = ""
                        if let pace = $0?.pace?.round(to: 2), pace > 0 {
                            let paceAsHour = pace / 3600
                            if paceAsHour > 1 {
                                paceAsString = "\(paceAsHour)"
                            }
                            
                            let paceAsMinutes = pace / 60
                            if paceAsMinutes > 0 {
                                if paceAsHour > 1 {
                                    paceAsString.append(contentsOf: ":")
                                }
                                paceAsString.append(contentsOf: "\(Int(paceAsMinutes))")
                            }

                            let paceAsSeconds = pace.truncatingRemainder(dividingBy: 60.0)
                            if paceAsSeconds > 0 {
                                if paceAsMinutes > 0 {
                                    paceAsString.append(contentsOf: ":")
                                }
                                paceAsString.append(contentsOf: "\(Int(paceAsSeconds))")
                            }
                        }

                        return Activity(id: $0?.id ?? "",
                                        title: $0?.title ?? "",
                                        description: $0?.description ?? "",
                                        createdAt: $0?.createdAt ?? Date(),
                                        creator: User(data: $0?.creator),
                                        coordinates: coordinates,
                                        duration: durationAsString,
                                        distance: "\(distance)" + " km",
                                        pace: paceAsString + " /km",
                                        activityImage: #imageLiteral(resourceName: "player5"),
                                        likes: likes,
                                        comments: comments,
                                        isActivityLiked: foundUserLike)
                        
                    default:
                        return nil
                    }
                    
                } ?? []
            }.asSingle()
    }
    
	func likePost(postUserID: String, userId: String, postID: String) -> Single<String?> {
		return Single.create { observer in

			let db = Firestore.firestore()
			let uid = Auth.auth().currentUser?.uid ?? ""
			db.collection("users").document(uid).getDocument { documentSnapshot, error in
				if let error = error {
					observer(.error(error))
				} else {
					let newDocumentID = UUID().uuidString
					db.collection("activities")
						.document(postUserID)
						.collection("userActivities")
						.document(postID)
						.collection("likes")
						.document(newDocumentID).setData([
							"user_id": userId,
							"creator": documentSnapshot?.data()
						], merge: true) { error in
							if let error = error {
								print("Error writing document: \(error)")
								observer(.error(error))
							} else {
								observer(.success(newDocumentID))
								print("Document successfully written!")
							}
						}
				}
			}

//			let docId = ref.parent?.documentID
//			ref.parent?.setData([
//				"user_id": userId
//			], completion: { error in
//				if let error = error {
//					print("Error writing document: \(error)")
//					observer(.error(error))
//				} else {
//					observer(.success(docId))
//					print("Document successfully written!")
//				}
//			})

//			db.collection("activities")
//				.document(postUserID)
//				.collection("userActivities")
//				.document(postID)
//				.collection("likes")
//				.addDocument(data: [
//					"user_id": userId
//				  ]) { error in
//					  if let error = error {
//						  print("Error writing document: \(error)")
//						  observer(.error(error))
//					  } else {
//						  observer(.success(true))
//						  print("Document successfully written!")
//					  }
//				  }

			return Disposables.create()
		}
//
//        return client.perform(mutation: LikePostMutation(userId: userID, postId: postID))
//            .map {
//                $0.likePost?.like?.id != nil
//            }
//            .asSingle()
    }
    
	func unlikePost(userID: String, postID: String, likeId: String) -> Single<Bool> {
//        return client.perform(mutation: UnlikePostMutation(userId: userID, postId: postID))
//            .map { $0.unlikePost?.success != nil }
//            .asSingle()
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
