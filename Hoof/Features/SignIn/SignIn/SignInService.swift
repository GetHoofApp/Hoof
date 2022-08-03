//
//  SignInService.swift
//  SignIn
//
//  Created Sameh Mabrouk on 24/06/2022.
//  Copyright © 2022 ___ORGANIZATIONNAME___. All rights reserved.
//

import RxSwift
import Apollo
import Core
import FirebaseAuth

public protocol SignInServicePerforming {
	func signIn(email: String, password: String) -> Single<String?>
}

class SignInService: SignInServicePerforming {
    
	private let firebaseAuth: Auth
    
    public init(firebaseAuth: Auth) {
		self.firebaseAuth = firebaseAuth
    }
    
    
	func signIn(email: String, password: String) -> Single<String?> {
		return Single.create { observer in
			Auth.auth().signIn(withEmail: email, password: password) { authResult, error in

				if let uid = authResult?.user.uid {
					observer(.success(uid))
				} else if let error = error {
					observer(.error(error))
				}
			}

			return Disposables.create()
		}
	}
}
