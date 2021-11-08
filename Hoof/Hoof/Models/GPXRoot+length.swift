//
//  GPXRoot+length.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 02/11/2021.
//

import Foundation
import MapKit
import CoreGPX

/// Extends GPXRoot to support getting the length of all tracks in meters
extension GPXRoot {
    
    /// Distance in meters of all the track segments
    public var tracksLength: CLLocationDistance {
        var tLength: CLLocationDistance = 0.0
        for track in self.tracks {
            tLength += track.length
        }
        return tLength
    }
}
