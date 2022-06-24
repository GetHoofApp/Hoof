//
//  DateTime.swift
//  Core
//
//  Created by Sameh Mabrouk on 06/01/2022.
//

import Apollo
import CodableGeoJSON

public typealias Upload = String

public typealias DateTime = Date

public typealias Decimal = Float

private let iso8601DateFormatter = ISO8601DateFormatter()

extension DateTime: JSONDecodable {
    
    public init(jsonValue value: JSONValue) throws {
        guard let string = value as? String else {
            throw JSONDecodingError.couldNotConvert(value: value, to: String.self)
        }
        
        guard let date = string.toDate(dateFormate: .yyyy_MM_dd_HH_mm_ss) else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Date.self)
        }
        
        self = date
    }
}

public typealias GeoJSON = CodableGeoJSON.GeoJSON

extension GeoJSON: JSONDecodable {
    
    public init(jsonValue value: JSONValue) throws {
        guard let dic = value as? Dictionary<String, Any> else {
            throw JSONDecodingError.couldNotConvert(value: value, to: Dictionary<String, Any>.self)
        }
        
        let coordinatesArray: [Any] = dic["coordinates"] as! [Any]
        let coordinates: [[Double]] = coordinatesArray[0] as! [[Double]]
        
        var geoJSONPositions = [GeoJSONPosition]()
        for array in coordinates {
            geoJSONPositions.append(GeoJSONPosition(longitude: array[0], latitude: array[1], elevation: nil))
        }
//        let coordinates = coordinatesArray[0]
        
        var geoJSON: CodableGeoJSON.GeoJSON
        geoJSON = .geometry(geometry: Geometry.multiLineString(coordinates: [geoJSONPositions]), boundingBox: nil)
                
        self = geoJSON
    }
}
