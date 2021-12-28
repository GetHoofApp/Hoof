//
//  AppConfig+Client.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 28/12/2021.
//

import Core

extension AppConfig: CoreConfigurable {
    public static var baseURL = Environment.string(for: .baseURL)
    public static var grahQLBaseURL = baseURL + "/graphql"
}
