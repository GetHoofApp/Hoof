//
//  AppService.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 11/02/2022.
//


import RxSwift
import Core
import CodableGeoJSON
//import Apollo
import Alamofire
import FirebaseAuth

protocol AppServicePerforming {
    func uploadActivity(title: String, description: String, gpxFile: GPXFileInfo) -> Single<Bool>
}

final class AppService: AppServicePerforming {
    
    func uploadActivity(title: String, description: String, gpxFile: GPXFileInfo) -> Single<Bool> {

		return Single.create { observer in
			do {
				let fileData = try Data(contentsOf: gpxFile.fileURL)
				let uid = Auth.auth().currentUser?.uid ?? ""

				let multipartEncoding: (MultipartFormData) -> Void = { multipartFormData in
					multipartFormData.append(fileData, withName: "file")
					multipartFormData.append(gpxFile.fileName.data(using: String.Encoding.utf8)!, withName: "file_name")
					multipartFormData.append(uid.data(using: String.Encoding.utf8)!, withName: "user_id")
					multipartFormData.append(title.data(using: String.Encoding.utf8)!, withName: "title")
					multipartFormData.append(description.data(using: String.Encoding.utf8)!, withName: "description")
				}

				Alamofire.upload(multipartFormData: multipartEncoding, with: Router.uploadActivity) { result in
					switch result {
					case .success(let request, _, _):
						observer(.success(true))
						break
					case .failure(let encodingError):
						observer(.success(false))
					}
				}
			} catch {
				observer(.success(false))
			}

			return Disposables.create()
		}

		/*
        do {
            let file = try GraphQLFile(fieldName: gpxFile.fileName, originalName: gpxFile.fileName, fileURL: gpxFile.fileURL)
            
            return client.upload(mutation: UploadActivityMutation(file: file.fieldName, title: title, description: description, userId: userID), files: [file])
                .map {
                    $0.createPost?.id != nil
                }
                .asSingle()
        } catch {
            return .just(false)
        }
		 */
    }
}
