//
//  ActivityCell.swift
//  Home
//
//  Created by Sameh Mabrouk on 09/11/2021.
//

import UIKit
import Core
import GoogleMaps
import GoogleMapsUtils
import CoreGPX
import CodableGeoJSON
import RxCocoa
import RxSwift
import Nuke

class ActivityCell: UITableViewCell, Dequeueable, GMSMapViewDelegate {
    
    private(set) var disposeBag = DisposeBag()

    private lazy var userImageView: UIImageView = {
        let image = UIImageView()
//        image.backgroundColor = UIColor(red: 223/255, green: 223/255, blfffcue: 231/255, alpha: 1.0)
//        image.clipsToBounds = true
//        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "athlete-placeholder")
        return image
    }()
    
    private lazy var image1: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "athlete-placeholder")
        return image
    }()
    
    private lazy var image2: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "athlete-placeholder")
        return image
    }()
    
    private lazy var image3: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "athlete-placeholder")
        return image
    }()
    
    private lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Jessica"
        label.font = .boldSystemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.text = "OCTOBER 26, 2021 AT 7:30 PM AMSTERDAM, NORTH HOLAND"
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var activityTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sunday Match"
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "Distance"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var spacing: CGFloat = 8.0
    
    private lazy var distanceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "30 KM"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paceLabel: UILabel = {
        let label = UILabel()
        label.text = "Avg Speed"
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var paceValueLabel: UILabel = {
        let label = UILabel()
        label.text = "5 /Km"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var durationLabel: UILabel = {
        let label = UILabel()
        label.text = "Game time"
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var durationValueLabel: UILabel = {
        let label = UILabel()
        label.text = "1h 15m"
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = UIColor(red: 56/255, green: 55/255, blue: 60/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var distanceStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var divider: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var paceStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var divider2: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var durationStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .vertical
        stackView.spacing = spacing
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var likesStackView: UIStackView = {
        let stackView = UIStackView(frame: .zero)
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = -5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var heatmapImage: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = #imageLiteral(resourceName: "heatmap")
        
        return image
    }()
    
    private var mapView: GMSMapView!
    private var heatmapLayer: GMUHeatmapTileLayer!
    private var gradientColors = [UIColor.green, UIColor.red, UIColor.blue]
    private var gradientStartPoints = [0.5, 0.8, 1.0] as [NSNumber]
    
    private lazy var kudosLabel: UILabel = {
        let label = UILabel()
        label.text = "Be the first to give a like!"
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public var kudosLabelLeftConstraint: NSLayoutConstraint!

    private lazy var commentsLabel: UILabel = {
        let label = UILabel()
        label.text = "2 comments"
        label.font = UIFont.systemFont(ofSize: 11.0)
        label.textColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var socialActivityView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 246/255, green: 246/255, blue: 246/255, alpha: 1.0)
        view.layer.shadowColor = UIColor.black.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var likeButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
        button.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        button.addTarget(self, action: #selector(self.likeButtonAction(_:)), for: .touchUpInside)

        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var likeButtonTap: ControlEvent<Void> {
        return likeButton.rx.tap
    }
    
    var commentButtonTap: ControlEvent<Void> {
        return commentButton.rx.tap
    }
    
    private lazy var socialActivityDivider1: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var commentButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "comment"), for: .normal)
        button.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var socialActivityDivider2: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setImage(#imageLiteral(resourceName: "share"), for: .normal)
        button.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
        
    let userId = "7"
    
    var userLike: Like!
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    override func prepareForReuse() {
       super.prepareForReuse()
       disposeBag = DisposeBag() // because life cicle of every cell ends on prepare for reuse
    }
    
    func configure(withActivity activity: Activity) {
        userLike = activity.likes?.first(where: { $0.creator?.id == userId })
        if userLike == nil {
            userLike = Like(id: "", creator: User(id: "7", firstName: "Sameh", lastName: "Mabrouk", photoURL: "images/ibrahimafellay.jpeg"))
        }
        
        if let firstName = activity.creator?.firstName, !firstName.isEmpty, let lastName = activity.creator?.lastName {
            userNameLabel.text = firstName + " " + lastName
        } else {
            userNameLabel.text = "Athlete"
        }
        
        dateLabel.text = activity.createdAt.toString(dateFormat: .yyyy_MM_dd_HH_mm_ss)
        
//        if activity.likes!.count > 0 || activity.likes!.count <= 3 {
//
//        }
                                                                                                                                                    
        activityTitleLabel.text = activity.title
        distanceValueLabel.text = activity.distance
        paceValueLabel.text = activity.pace
        durationValueLabel.text = activity.duration
        
        if let comments = activity.comments, !comments.isEmpty {
            commentsLabel.text = "\(comments.count)" + " comments"
        } else {
            commentsLabel.text = ""
        }

        kudosLabel.text = "Be the first to give a like!"

        addHeatmap(coordinates: activity.coordinates)
        
        if activity.isActivityLiked {
            likeButton.tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up-selected"), for: .normal)
        } else {
            likeButton.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
        }
        
        self.activity = activity
        formateLikesLabelText(activity: activity)
    }
    
    var activity: Activity!
    
    // MARK: - UIButton Action
    @objc func likeButtonAction(_ button: UIButton) {
        if self.activity.isActivityLiked {
            self.activity.isActivityLiked = false
            likeButton.tintColor = UIColor(red: 115/255, green: 114/255, blue: 119/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up"), for: .normal)
//            kudosLabel.text = "Be the first to give a like!"
            
            // Update likes array locally by removing the likes of current logged in user to make the UI updates fast without hitting the server, any way
            // all activities will be reloaded when refreshing the feed screen.
            activity.likes?.removeAll(where: {
                $0.creator?.id == userId
            })
            
            updateActivityLikabilityStatus()
            formateLikesLabelText(activity: activity)

//            image1.isHidden = true
//            kudosLabelLeftConstraint.constant = 16
            
        } else {
            self.activity.isActivityLiked = true
            likeButton.tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
            likeButton.setImage(#imageLiteral(resourceName: "thumb-up-selected"), for: .normal)
            
            // Add the the likes of current logged in user to the likes array of the activity to make the UI updates fast without hitting the server, any way
            // all activities will be reloaded when refreshing the feed screen.
            if let userLike = userLike {
                activity.likes?.append(userLike)
            }
            
//            kudosLabel.text = "You gave a like"
            updateActivityLikabilityStatus()
            formateLikesLabelText(activity: activity)
            
//            image1.isHidden = false
//            kudosLabelLeftConstraint.constant = 63
        }
    }
}

// MARK: Helpers

private extension ActivityCell {
    
    func formateLikesLabelText(activity: Activity) {
        switch activity.activityLikabilityStatus {
        case .beTheFirstToGiveALike:
            kudosLabel.text = "Be the first to give a like!"
            kudosLabelLeftConstraint.constant = 16
        case .youAndOneOthersGaveALike:
            if let likes = activity.likes, !likes.isEmpty {
                kudosLabel.text = "You and " + "\(likes.count)" + " others gave likes"
            }
            kudosLabelLeftConstraint.constant = 88
        case .youAndXOthersGaveALike:
            if let likes = activity.likes, !likes.isEmpty {
                kudosLabel.text = "You and " + "\(likes.count)" + " others gave likes"
            }
            kudosLabelLeftConstraint.constant = 113
        case .xGaveLikes, .oneGaveLikes, .twoGaveLikes:
            if let likes = activity.likes, !likes.isEmpty {
                kudosLabel.text = "\(likes.count)" + " gave likes"
            }
            kudosLabelLeftConstraint.constant = 113
        case .youGaveALike:
            kudosLabel.text = "You gave a like"
            kudosLabelLeftConstraint.constant = 63
        default:
            kudosLabel.text = "Be the first to give a like!"
        }
        
        let placeholder = #imageLiteral(resourceName: "athlete-placeholder")
        
        if activity.likes?.count == 3 {
            image1.isHidden = false
            image2.isHidden = false
            image3.isHidden = false
            likesStackView.addArrangedSubview(image1)
            likesStackView.addArrangedSubview(image2)
            likesStackView.addArrangedSubview(image3)
//            kudosLabelLeftConstraint.constant = 113
            
            if let like = activity.likes?[1], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/ibrahimafellay.jpeg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image2, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image2.makeRounded()
                    }
                })
            }
            
            if let like = activity.likes?[0], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/test.jpg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image1, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image1.makeRounded()
                    }
                })
            }
            
            if let like = activity.likes?[2], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/ibrahimafellay.jpeg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image3, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image3.makeRounded()
                    }
                })
            }
        }
        
        if activity.likes?.count == 2 {
            image1.isHidden = false
            image2.isHidden = false
            image3.isHidden = true
            likesStackView.addArrangedSubview(image1)
            likesStackView.addArrangedSubview(image2)
//            kudosLabelLeftConstraint.constant = 88
            
            if let like = activity.likes?[1], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/ibrahimafellay.jpeg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image2, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image2.makeRounded()
                    }
                })
            }
            
            if let like = activity.likes?[0], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/test.jpg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image1, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image1.makeRounded()
                    }
                })
            }
        }
        
//        if activity.likes?.count == 0 {
//            likesStackView.subviews.forEach { view in
//                likesStackView.removeArrangedSubview(view)
//            }
//        }
//
        if activity.likes?.count == 1 {
            image2.isHidden = true
            image3.isHidden = true
            image1.isHidden = false
            likesStackView.addArrangedSubview(image1)
//            kudosLabelLeftConstraint.constant = 63
            if let like = activity.likes?[0], let photoURLString = like.creator?.photoURL, let photoURL = URL(string: Config.baseURL + "/media/" + "images/ibrahimafellay.jpeg") {
                Nuke.loadImage(with: photoURL, options: ImageLoadingOptions(placeholder: placeholder, transition: nil, failureImage: placeholder, failureImageTransition: nil, contentModes: nil), into: image1, completion: { [weak self] response , _ in
                    DispatchQueue.main.async {
                        self?.image1.makeRounded()
                    }
                })
            }
        }
        
        if activity.likes?.count == 0 {
            image1.isHidden = true
            image2.isHidden = true
            image3.isHidden = true
//            kudosLabelLeftConstraint.constant = 16
        }
                
        if let userPhotoURLString = activity.creator?.photoURL, !userPhotoURLString.isEmpty, let userPhotoURL = URL(string: Config.baseURL + "/media/" + userPhotoURLString) {
            Nuke.loadImage(with: userPhotoURL, into: userImageView, completion: { [weak self] response , _ in
                self?.userImageView.makeRounded()
            })
        } else {
            userImageView.image = #imageLiteral(resourceName: "athlete-placeholder")
        }
    }
    
    func updateActivityLikabilityStatus() {
        switch activity.activityLikabilityStatus {
        case .beTheFirstToGiveALike:
            activity.activityLikabilityStatus = .youGaveALike
        case .youAndXOthersGaveALike:
            activity.activityLikabilityStatus = .xGaveLikes
        case .youGaveALike:
            activity.activityLikabilityStatus = .beTheFirstToGiveALike
        case .youAndOneOthersGaveALike:
            activity.activityLikabilityStatus = .oneGaveLikes
        case .xGaveLikes, .twoGaveLikes:
            activity.activityLikabilityStatus = .youAndXOthersGaveALike
        case .oneGaveLikes:
            activity.activityLikabilityStatus = .youAndOneOthersGaveALike
        case .unkown:
            activity.activityLikabilityStatus = .unkown
        }
    }
}

// MARK: - Setup UI

private extension ActivityCell {
    
    func setupUI() {
        backgroundColor = .white
        
        selectionStyle = .none
        
        // Google maps
//        let camera = GMSCameraPosition.camera(withLatitude: 52.2772250, longitude: 5.1425520, zoom: 17)
        mapView = GMSMapView(frame: .zero)

//        let vancouver = CLLocationCoordinate2D(latitude: 52.277225, longitude: 5.142552)
//        let calgary = CLLocationCoordinate2D(latitude: 52.277225,longitude: 5.142552)
//        let bounds = GMSCoordinateBounds(coordinate: vancouver, coordinate: calgary)
//        let camera = mapView.camera(for: bounds, insets: UIEdgeInsets())!
//        mapView.camera = camera
        
        mapView.mapType = .satellite
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
//        mapView.settings.scrollGestures = true
//        mapView.settings.zoomGestures = true
//        mapView.isUserInteractionEnabled = true
        // Set heatmap options.
        heatmapLayer = GMUHeatmapTileLayer()
        heatmapLayer.radius = 120
        heatmapLayer.opacity = 5.0
        heatmapLayer.gradient = GMUGradient(colors: gradientColors,
                                            startPoints: gradientStartPoints,
                                            colorMapSize: 256)
//        addHeatmap()
        
        // Set the heatmap to the mapview.
        heatmapLayer.map = mapView    
        
        setupSubviews()
        setupConstraints()
        
        image1.makeRounded()
        image2.makeRounded()
        image3.makeRounded()
        
//        userImageView.layer.cornerRadius = userImageView.frame.size.width / 2
//        userImageView.clipsToBounds = true
    }
    
    func addHeatmap(coordinates: MultiLineStringGeometry.Coordinates) {
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
    
    // Parse JSON data and add it to the heatmap layer.
    func addHeatmap() {
//        var list = [GMUWeightedLatLng]()
//        var list1 = [GMUWeightedLatLng]()
//
//
//        if let inputURL = Bundle.main.url(forResource: "Avondactiviteit", withExtension: "gpx") {
//            guard let gpx = GPXParser(withURL: inputURL)?.parsedData() else { return }
//
//            // waypoints, tracks, tracksegements, trackpoints are all stored as Array depends on the amount stored in the GPX file.
//            for waypoint in gpx.tracks[0].segments[0].points {  // for loop example, every waypoint is written
//                print(waypoint.latitude ?? 0.0)     // prints every waypoint's latitude, etc: 1.3521, as a Double object
//                print(waypoint.longitude ?? 0.0)    // prints every waypoint's longitude, etc: 103.8198, as a Double object
//                let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(waypoint.latitude ?? 0.0, waypoint.longitude ?? 0.0), intensity: 1.0)
//                list.append(coords)
//            }
//        }
         
//        print("======================================================== New Coodinates ========================================================")
//        for coordinate in coordinates[0] {
////            print(coordinate.latitude)
////            print(coordinate.longitude)
//            let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(coordinate.longitude, coordinate.latitude), intensity: 10.0)
//            list.append(coords)
//        }
        // Add the latlngs to the heatmap layer.
//        heatmapLayer.weightedData = list
//        heatmapLayer.map = mapView
    }
    
    /*
     func addMapboxMap() {
         let myResourceOptions = ResourceOptions(accessToken: "pk.eyJ1Ijoic2FtZWhtYWJyb3VrIiwiYSI6ImNreGc2dWE2NzAxeGIydmx0dG43OGRwZHUifQ.xR8lovpq4v7oJe0HjdyJNA")
         let cameraOptions = CameraOptions(center: CLLocationCoordinate2D(latitude: 51.9875090, longitude: 6.6087430),
                                                   zoom: 16,
                                                   bearing: -21,
                                                   pitch: 90)
         // Pass camera options to map init options
         let myMapInitOptions = MapInitOptions(resourceOptions: myResourceOptions, cameraOptions: cameraOptions, styleURI: .satellite)
         mapView = MapView(frame: .zero, mapInitOptions: myMapInitOptions)
         mapView.translatesAutoresizingMaskIntoConstraints = false
         
     }
     
    func addMapboxHeatmap() {
        let sourceId = "earthquake-source"
        var imageSource = ImageSource()
         // Create the heatmap layer using the specified layer and source IDs.
         var layer = HeatmapLayer(id: "earthquake-heatmap-layer")
        
//         layer.source = sourceId
         // Set the heatmap layer's color property.
         layer.heatmapColor = .expression(
             Exp(.interpolate) {
                 Exp(.linear)
                 Exp(.heatmapDensity)
                 0
                 UIColor.clear
                 0.2
                 UIColor.blue
                 0.4
                 UIColor.green
                 0.6
                 UIColor.yellow
                 0.8
                 UIColor.orange
                 1.0
                 UIColor.red
         })

        
        
        var list = [GMUWeightedLatLng]()
        var coordList = [[Double]]()
        if let inputURL = Bundle.main.url(forResource: "KSV_4_to_the_stars_beyond_", withExtension: "gpx") {
            guard let gpx = GPXParser(withURL: inputURL)?.parsedData() else { return }
                    
            // waypoints, tracks, tracksegements, trackpoints are all stored as Array depends on the amount stored in the GPX file.
            for waypoint in gpx.tracks[0].segments[0].points {  // for loop example, every waypoint is written
                print(waypoint.latitude ?? 0.0)     // prints every waypoint's latitude, etc: 1.3521, as a Double object
                print(waypoint.longitude ?? 0.0)    // prints every waypoint's longitude, etc: 103.8198, as a Double object
                let coords = GMUWeightedLatLng(coordinate: CLLocationCoordinate2DMake(waypoint.latitude ?? 0.0, waypoint.longitude ?? 0.0), intensity: 1.0)
                list.append(coords)
                coordList.append([waypoint.latitude ?? 0.0, waypoint.longitude ?? 0.0])
            }
        }
        
        imageSource.coordinates = coordList
        try! mapView.mapboxMap.style.addSource(imageSource, id: sourceId)

        // Add the heatmap layer to the map.
       try! mapView.mapboxMap.style.addLayer(layer)
    }
    
    */
    func setupSubviews() {
        contentView.addSubview(userImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(activityTitleLabel)
        
        distanceStackView.addArrangedSubview(distanceLabel)
        distanceStackView.addArrangedSubview(distanceValueLabel)
        
        paceStackView.addArrangedSubview(paceLabel)
        paceStackView.addArrangedSubview(paceValueLabel)
        
        durationStackView.addArrangedSubview(durationLabel)
        durationStackView.addArrangedSubview(durationValueLabel)
        
        contentView.addSubview(distanceStackView)
        contentView.addSubview(divider)
        contentView.addSubview(paceStackView)
        contentView.addSubview(divider2)
        contentView.addSubview(durationStackView)
        
        //        addSubview(heatmapImage)
        contentView.addSubview(mapView)
        
        contentView.addSubview(likesStackView)
        
        contentView.addSubview(kudosLabel)
        contentView.addSubview(commentsLabel)
        
        socialActivityView.addSubview(likeButton)
        socialActivityView.addSubview(socialActivityDivider1)
        socialActivityView.addSubview(commentButton)
        socialActivityView.addSubview(socialActivityDivider2)
        socialActivityView.addSubview(shareButton)
        contentView.addSubview(socialActivityView)
    }
    
    func setupConstraints() {
        kudosLabelLeftConstraint = kudosLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16)
        kudosLabelLeftConstraint.priority = UILayoutPriority(rawValue: 300)

        NSLayoutConstraint.activate([
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            userImageView.widthAnchor.constraint(equalToConstant: 50),
            userImageView.heightAnchor.constraint(equalToConstant: 50),
            
            userNameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 11),
            userNameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
//            userNameLabel.heightAnchor.constraint(equalToConstant: 18),
                        
            dateLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 7),
            dateLabel.leftAnchor.constraint(equalTo: userNameLabel.leftAnchor, constant: 0),
            dateLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
//            dateLabel.heightAnchor.constraint(equalToConstant: 29),
            
            activityTitleLabel.topAnchor.constraint(equalTo: dateLabel.bottomAnchor, constant: 32),
            activityTitleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            activityTitleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            
            distanceStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            distanceStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 21),
            //            distanceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            divider.leftAnchor.constraint(equalTo: distanceStackView.rightAnchor, constant: 37),
            divider.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 30),
            divider.widthAnchor.constraint(equalToConstant: 1),
            divider.heightAnchor.constraint(equalToConstant: 25),
            
            paceStackView.leftAnchor.constraint(equalTo: divider.leftAnchor, constant: 28),
            paceStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 21),
            //            paceStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -50),
            
            divider2.leftAnchor.constraint(equalTo: paceStackView.rightAnchor, constant: 37),
            divider2.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 30),
            divider2.widthAnchor.constraint(equalToConstant: 1),
            divider2.heightAnchor.constraint(equalToConstant: 25),
            
            durationStackView.leftAnchor.constraint(equalTo: divider2.leftAnchor, constant: 28),
            durationStackView.topAnchor.constraint(equalTo: activityTitleLabel.bottomAnchor, constant: 21),
            
            mapView.topAnchor.constraint(equalTo: paceStackView.bottomAnchor, constant: 12),
            mapView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
            mapView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            mapView.heightAnchor.constraint(equalToConstant: 250),
            //            heatmapImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10),
            
//            image1.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
//            image1.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 22),
//            image1.widthAnchor.constraint(equalToConstant: 35),
//            image1.heightAnchor.constraint(equalToConstant: 35),
//            image1.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -57),
//
//            image2.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 15),
//            image2.leftAnchor.constraint(equalTo: image1.rightAnchor, constant: -5),
//            image2.widthAnchor.constraint(equalToConstant:35),
//            image2.heightAnchor.constraint(equalToConstant: 35),
//            image2.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -57),
//
//            image3.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 15),
//            image3.leftAnchor.constraint(equalTo: image2.rightAnchor, constant: -5),
//            image3.widthAnchor.constraint(equalToConstant: 35),
//            image3.heightAnchor.constraint(equalToConstant: 35),
//            image3.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -57),
            
            image1.widthAnchor.constraint(equalToConstant: 32),
            image1.heightAnchor.constraint(equalToConstant: 32),
            likesStackView.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 16),
            likesStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            likesStackView.heightAnchor.constraint(equalToConstant: 32),
//            likesStackView.widthAnchor.constraint(equalToConstant: 85),
//            likesStackView.bottomAnchor.constraint(equalTo: socialActivityView.topAnchor, constant: 10),
            likesStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -57),

//            kudosLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
//            kudosLabel.leftAnchor.constraint(equalTo: likesStackView.rightAnchor, constant: 12),
            kudosLabelLeftConstraint,
            kudosLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
            kudosLabel.heightAnchor.constraint(equalToConstant: 32),
            kudosLabel.centerYAnchor.constraint(equalTo: likesStackView.centerYAnchor),
            
//            commentsLabel.topAnchor.constraint(equalTo: mapView.bottomAnchor, constant: 12),
            commentsLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            commentsLabel.heightAnchor.constraint(equalToConstant: 32),
            commentsLabel.centerYAnchor.constraint(equalTo: likesStackView.centerYAnchor),
            
            socialActivityView.topAnchor.constraint(equalTo: kudosLabel.bottomAnchor, constant: 18),
            socialActivityView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            socialActivityView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            socialActivityView.heightAnchor.constraint(equalToConstant: 49),
            
            likeButton.leftAnchor.constraint(equalTo: socialActivityView.leftAnchor, constant: 59),
            likeButton.widthAnchor.constraint(equalToConstant: 26),
            likeButton.heightAnchor.constraint(equalToConstant: 26),
            likeButton.centerYAnchor.constraint(equalTo: socialActivityView.centerYAnchor),
            
            socialActivityDivider1.leftAnchor.constraint(equalTo: likeButton.rightAnchor, constant: 45),
            socialActivityDivider1.widthAnchor.constraint(equalToConstant: 1),
            socialActivityDivider1.heightAnchor.constraint(equalToConstant: 25),
            socialActivityDivider1.centerYAnchor.constraint(equalTo: socialActivityView.centerYAnchor),
            
            commentButton.leftAnchor.constraint(equalTo: socialActivityDivider1.rightAnchor, constant: 48),
            commentButton.widthAnchor.constraint(equalToConstant: 26),
            commentButton.heightAnchor.constraint(equalToConstant: 26),
            commentButton.centerYAnchor.constraint(equalTo: socialActivityView.centerYAnchor),
            
            socialActivityDivider2.leftAnchor.constraint(equalTo: commentButton.rightAnchor, constant: 52),
            socialActivityDivider2.widthAnchor.constraint(equalToConstant: 1),
            socialActivityDivider2.heightAnchor.constraint(equalToConstant: 25),
            socialActivityDivider2.centerYAnchor.constraint(equalTo: socialActivityView.centerYAnchor),
            
            shareButton.leftAnchor.constraint(equalTo: socialActivityDivider2.rightAnchor, constant: 51),
            shareButton.widthAnchor.constraint(equalToConstant: 26),
            shareButton.heightAnchor.constraint(equalToConstant: 26),
            shareButton.centerYAnchor.constraint(equalTo: socialActivityView.centerYAnchor)
        ])
    }
}
