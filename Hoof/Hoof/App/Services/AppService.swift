//
//  AppService.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 11/02/2022.
//


import RxSwift
import Core
import CodableGeoJSON
import Apollo

protocol AppServicePerforming {
    func uploadActivity(title: String, description: String, userID: String, gpxFile: GPXFileInfo) -> Single<Bool>
}

final class AppService: AppServicePerforming {
    
    private let client: GraphQLClientProtocol
    
    init(client: GraphQLClientProtocol) {
        self.client = client
    }
    
    func uploadActivity(title: String, description: String, userID: String, gpxFile: GPXFileInfo) -> Single<Bool> {
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
    }
}
