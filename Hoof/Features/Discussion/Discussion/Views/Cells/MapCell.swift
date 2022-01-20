//
//  MapCell.swift
//  Discussion
//
//  Created by Sameh Mabrouk on 13/01/2022.
//

import UIKit
import Core
import GoogleMaps
import GoogleMapsUtils
import CodableGeoJSON

class MapCell: UITableViewCell, Dequeueable, GMSMapViewDelegate {
    
    private var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var gradientColors = [UIColor.green, UIColor.red, UIColor.blue]
    private var gradientStartPoints = [0.5, 0.8, 1.0] as [NSNumber]
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    func configure(with coordinates: MultiLineStringGeometry.Coordinates) {
        var list = [GMUWeightedLatLng]()
        
        for coordinate in coordinates[0] {
            let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(coordinate.longitude, coordinate.latitude), intensity: 10.0)
            list.append(coords)
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: coordinates[0][0].longitude, longitude: coordinates[0][0].latitude, zoom: 17)
        mapView.camera = camera
        // Add the latlngs to the heatmap layer.
        heatmapLayer.weightedData = list
        heatmapLayer.map = mapView
    }
}

// MARK: - Setup UI

private extension MapCell {
    
    func setupUI() {
        mapView = GMSMapView(frame: .zero)
        mapView.mapType = .satellite
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 120
        heatmapLayer.opacity = 5.0
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 256)
        heatmapLayer.map = mapView

        setupSubviews()
        setupConstraints()
        
        selectionStyle = .none
    }
    
    func setupSubviews() {
        contentView.addSubview(mapView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: contentView.topAnchor),
            mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            mapView.heightAnchor.constraint(equalToConstant: 204),
            mapView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}


