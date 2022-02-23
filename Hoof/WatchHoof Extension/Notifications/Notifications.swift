//
//  Notifications.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 10/02/2022.
//

import Foundation

extension Notification.Name {
    static let ActivityPaused = "ActivityPaused"
    static let ActivityResumed = "ActivityResumed"
    static let WaterLockEnabled = "WaterLockEnabled"
    static let SecondHalfStarted = Notification.Name("SecondHalfStarted")
    
    static let EndGameWithOnlyFirstHalf = Notification.Name("EndGameWithOnlyFirstHalf")
    static let FirstHalfEnding = Notification.Name("FirstHalfEnding")
    static let PositionSelectedForFirstHalf = Notification.Name("PositionSelectedForFirstHalfEnded")
    
    static let SecondHalfEnded = "SecondHalfEnded"
    static let ActivityEnded = Notification.Name("ActivityEnded")
}
