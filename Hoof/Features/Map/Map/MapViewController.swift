//
//  MapViewController.swift
//  Map
//
//  Created Sameh Mabrouk on 11/11/2021.
//  Copyright © 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import Core
import MapKit
import DrawerView

class MapViewController: ViewController<MapViewModel> {
    
    // MARK: - Properties
    
    private lazy var mapView: MKMapView = {
        let mapView = MKMapView(frame: .zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        mapView.showsUserLocation = true
        return mapView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero)
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableView.automaticDimension
        tableView.registerCell(withType: ActivityCell.self)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .white
        return tableView
    }()
    
    private let drawerView: DrawerView = {
       let drawerView = DrawerView()
        drawerView.backgroundColor = .white
        return drawerView
    }()
    
    private lazy var topView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .red
        view.layer.cornerRadius = 2.5
        view.backgroundColor = UIColor(red: 64/255, green: 64/255, blue: 64/255, alpha: 0.3)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var checkedInLabel: UILabel = {
        let label = UILabel()
        label.text = "Checked-in players"
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nearbyAthletes: [(name: String, image: UIImage)] = [("Ronald", #imageLiteral(resourceName: "player1")), ("Sonya", #imageLiteral(resourceName: "player2")), ("Ibrahim", #imageLiteral(resourceName: "player3")), ("Jack", #imageLiteral(resourceName: "player4")), ("Chris", #imageLiteral(resourceName: "player5"))]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.inputs.viewState.onNext(.loaded)
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    // MARK: - setupUI
    
    override func setupUI() {
        setupSubviews()
        setupConstraints()
        setupNavogationBar()
        setupObservers()
        
        drawerView.snapPositions = [.closed, .collapsed, .partiallyOpen, .open]
        drawerView.setPosition(.closed, animated: true)
        view.backgroundColor = .white
    }
    
    override func setupConstraints() {
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor),
            mapView.leftAnchor.constraint(equalTo: view.leftAnchor),
            mapView.rightAnchor.constraint(equalTo: view.rightAnchor),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            tableView.topAnchor.constraint(equalTo: drawerView.topAnchor, constant: 50),
            tableView.leftAnchor.constraint(equalTo: drawerView.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: drawerView.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: drawerView.bottomAnchor),
            
            topView.topAnchor.constraint(equalTo: drawerView.topAnchor, constant: 5),
            topView.heightAnchor.constraint(equalToConstant: 5),
            topView.widthAnchor.constraint(equalToConstant: 36),
            topView.centerXAnchor.constraint(equalTo: drawerView.centerXAnchor),
                        
            checkedInLabel.topAnchor.constraint(equalTo: topView.bottomAnchor, constant: 5),
            checkedInLabel.leftAnchor.constraint(equalTo: drawerView.leftAnchor, constant: 20),
            checkedInLabel.rightAnchor.constraint(equalTo: drawerView.rightAnchor, constant: 0),
            checkedInLabel.heightAnchor.constraint(equalToConstant: 42)
        ])
    }
    
    func setupSubviews() {
        view.addSubview(mapView)
        drawerView.addSubview(topView)
        drawerView.addSubview(checkedInLabel)
        drawerView.addSubview(tableView)
        drawerView.attachTo(view: view)
    }
    
    private func setupNavogationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func setupObservers() {
        viewModel.outputs.showUserLocation.subscribe { [weak self] (lat, lng) in
            let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
            let center = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            let region = MKCoordinateRegion(center: center, span: span)
            self?.mapView.setRegion(region, animated: true)
            
            // Show annotation
            let sportCourtAnnotation1 = SportCourtAnnotation(coordinate: CLLocationCoordinate2D(latitude: 52.385947485890824, longitude: 4.828984342874879), title: "Footy Park Amsterdam", subtitle: "", category: "")
            let sportCourtAnnotation2 = SportCourtAnnotation(coordinate: CLLocationCoordinate2D(latitude: 52.34225482892833, longitude: 4.851477742481861), title: "ASV Arsenal", subtitle: "", category: "")
            let sportCourtAnnotation3 = SportCourtAnnotation(coordinate: CLLocationCoordinate2D(latitude: 52.35525162213395, longitude: 4.917513336060959), title: "Cruyff Court Ajax Joubertstraat", subtitle: "", category: "")
            
            self?.mapView.addAnnotation(sportCourtAnnotation1)
            self?.mapView.addAnnotation(sportCourtAnnotation2)
            self?.mapView.addAnnotation(sportCourtAnnotation3)
        }.disposed(by: viewModel.disposeBag)
    }
    
    func zoomMapaFitAnnotations() {
        var zoomRect = MKMapRect.null
        for annotation in mapView.annotations {
            
            let annotationPoint = MKMapPoint(annotation.coordinate)
            
            let pointRect = MKMapRect(x: annotationPoint.x, y: annotationPoint.y, width: 0, height: 0)
            
            if (zoomRect.isNull) {
                zoomRect = pointRect
            } else {
                zoomRect = zoomRect.union(pointRect)
            }
        }
        self.mapView.setVisibleMapRect(zoomRect, edgePadding: UIEdgeInsets(top: 50, left: 50, bottom: 50, right: 50), animated: true)
    }
}

// MARK: - MKMapViewDelegate

extension MapViewController: MKMapViewDelegate {
    
    // View for each annotation
    internal func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        // This keeps the user location point as a default blue dot.
        if annotation is MKUserLocation { return nil }
        
        // Setup annotation view for map - we can fully customize the marker
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "PlaceAnnotationView") as? MKMarkerAnnotationView
        
        // Setup annotation view
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: "PlaceAnnotationView")
            annotationView?.glyphImage = #imageLiteral(resourceName: "soccer-ball")
            annotationView?.canShowCallout = false
            annotationView?.animatesWhenAdded = true
            annotationView?.markerTintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
//            annotationView?.glyphTintColor = .white
            annotationView?.isHighlighted = true
        } else {
            annotationView?.annotation = annotation
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        drawerView.setPosition(.partiallyOpen, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MapViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.getCell(forType: ActivityCell.self)
        let athlete = nearbyAthletes[indexPath.row]
        
        cell.setup(image: athlete.image, userName: athlete.name)

        return cell
    }
}

// MARK: - UITableViewDataSource

extension MapViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


