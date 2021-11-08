//
//  StopWatchDelegate.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 02/11/2021.
//

import Foundation

/// This protocol is used to inform the delegate that the elapsed time was updated.
/// Provides the elapsed time as a string
protocol StopWatchDelegate: AnyObject {
    
    /// Called when the stopwatch updated the elapsed time.
    func stopWatch(_ stropWatch: StopWatch, didUpdateElapsedTimeString elapsedTimeString: String)
}
