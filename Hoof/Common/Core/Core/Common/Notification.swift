//
//  Notification.swift
//  Core
//
//  Created by Sameh Mabrouk on 10/02/2022.
//

/// Notifications for file receival from external source.
public extension Notification.Name {
    
    /// Use when a file is received from external source.
    static let didReceiveFileFromURL = Notification.Name("didReceiveFileFromURL")
    
    /// Use when a file is received from Apple Watch.
    static let didReceiveFileFromAppleWatch = Notification.Name("didReceiveFileFromAppleWatch")
}
