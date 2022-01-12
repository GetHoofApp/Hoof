//
//  Post.swift
//  Home
//
//  Created by Sameh Mabrouk on 06/01/2022.
//

import CodableGeoJSON
import Core

public struct Post {
    let title: String
    let description: String
    let createdAt: Date
    let coordinates: MultiLineStringGeometry.Coordinates
}
