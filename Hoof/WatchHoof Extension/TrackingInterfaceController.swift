//
//  TrackingInterfaceController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 07/02/2022.
//

import WatchKit
import Foundation
import WatchConnectivity
import HealthKit
import CoreMotion

class TrackingInterfaceController: WKInterfaceController {
    
    // MARK: - Properties
    @IBOutlet weak var userMovementLabel: WKInterfaceLabel!

    @IBOutlet weak var timeLabel: WKInterfaceLabel!
    @IBOutlet weak var speedLabel: WKInterfaceLabel!
    @IBOutlet weak var totalTrackedDistanceLabel: WKInterfaceLabel!
    @IBOutlet weak var heartRateValueLabel: WKInterfaceLabel!
    @IBOutlet weak var sceneInterface: WKInterfaceSKScene!
    
    /// Watch communication session
    private let session: WCSession? = WCSession.isSupported() ? WCSession.default: nil
    
    /// Location Manager
    let locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.requestAlwaysAuthorization()
        
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.activityType = .fitness
        manager.distanceFilter = 10 //meters
        manager.allowsBackgroundLocationUpdates = true
        manager.headingFilter = 3 //degrees (1 is default)
        return manager
    }()
    
    /// Preferences loader
    let preferences = Preferences.shared
    
    /// Underlying class that handles background stuff
    let map = GPXMapView() // not even a map view. Considering renaming
    
    //Status Vars
    var stopWatch = StopWatch()
    var lastGpxFilename: String = ""
    var wasSentToBackground: Bool = false //Was the app sent to background
    var isDisplayingLocationServicesDenied: Bool = false
    
    /// Does the 'file' have any waypoint?
    var hasWaypoints: Bool = false {
        /// Whenever it is updated, if it has waypoints it sets the save and reset button
        didSet {
            if hasWaypoints {
                //                saveButton.setBackgroundColor(kBlueButtonBackgroundColor)
                //                resetButton.setBackgroundColor(kRedButtonBackgroundColor)
            }
        }
    }
    
    /// Defines the different statuses regarding tracking current user location.
    enum GpxTrackingStatus {
        
        /// Tracking has not started or map was reset
        case notStarted
        
        /// Tracking is ongoing
        case tracking
        
        /// Tracking is paused (the map has some contents)
        case paused
    }
    
    /// Tells what is the current status of the Map Instance.
    var gpxTrackingStatus: GpxTrackingStatus = GpxTrackingStatus.notStarted {
        didSet {
            print("gpxTrackingStatus changed to \(gpxTrackingStatus)")
            switch gpxTrackingStatus {
            case .notStarted:
                print("switched to non started")
                stopWatch.reset()
                
                map.reset() //reset gpx logging
                lastGpxFilename = "" //clear last filename, so when saving it appears an empty field
                
            case .tracking:
                print("switched to tracking mode")
                // start clock
                self.stopWatch.start()
                
                // start heart rate monitoring
                startHeartRateQuery(quantityTypeIdentifier: .heartRate)
                sceneInterface.isPaused = false
                
            case .paused:
                print("switched to paused mode")
                //pause clock
                self.stopWatch.stop()
                // start new track segment
                self.map.startNewTrackSegment()
            }
        }
    }
    
    /// Editing Waypoint Temporal Reference
    var lastLocation: CLLocation? //Last point of current segment.
    
    private var healthStore = HKHealthStore()
    private let heartRateQuantity = HKUnit(from: "count/min")
    private var query: HKAnchoredObjectQuery!
    
    private var isDeviceMoving = false
    
    private lazy var motionManager: CMMotionManager = {
        let motionManager = CMMotionManager()
        motionManager.accelerometerUpdateInterval = 0.2
        return motionManager
    }()
    
    private lazy var pedometer: CMPedometer = {
        let pedometer = CMPedometer()
        return pedometer
    }()
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        autorizeHealthKit()
        
        // Configure interface objects here.
        totalTrackedDistanceLabel.setText(0.00.toDistance(useImperial: preferences.useImperial))
        gpxTrackingStatus = .tracking
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.activityResumed(notification:)), name: Notification.Name(rawValue: Notification.Name.ActivityResumed), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.activityPaused(notification:)), name: Notification.Name(rawValue: Notification.Name.ActivityPaused), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.waterLockEnabled(notification:)), name: Notification.Name(rawValue: Notification.Name.WaterLockEnabled), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.activityEnded(notification:)), name: .ActivityEnded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.secondHalfStarted(notification:)), name: .SecondHalfStarted, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(self.firstHalfEnding(notification:)), name: .FirstHalfEnding, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.firstHalfEnded(notification:)), name: .EndGameWithOnlyFirstHalf, object: nil)
        
        session?.delegate = self
        session?.activate()
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        stopWatch.delegate = self
        
        startMotionUpdates()
        
        locationManager.delegate = self
        checkLocationServicesStatus()
        locationManager.startUpdatingLocation()
        
        session?.delegate = self
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
        print("InterfaceController:: didDeactivate called")
        
        if gpxTrackingStatus != .tracking {
            print("InterfaceController:: didDeactivate will stopUpdatingLocation")
            locationManager.stopUpdatingLocation()
        }
    }
    
    @objc private func activityPaused(notification: NSNotification) {
        gpxTrackingStatus = .paused
        healthStore.stop(query)
        sceneInterface.isPaused = true
    }
    
    @objc private func activityResumed(notification: NSNotification) {
        gpxTrackingStatus = .tracking
        becomeCurrentPage()
    }
    
    @objc private func waterLockEnabled(notification: NSNotification) {
        becomeCurrentPage()
    }
    
    @objc private func activityEnded(notification: NSNotification) {
        // End of match
        // Save the gpx file and send it to iPhone app to upload the activity to server
        let filename = defaultFilename(prefix: "second-half")
        let gpxString = self.map.exportToGPXString()
        GPXFileManager.save(filename, gpxContents: gpxString)
        
        gpxTrackingStatus = .paused
        
        sendActivationMessage()
    }
    
    @objc private func firstHalfEnded(notification: NSNotification) {
        // End of match
        // Save the gpx file and send it to iPhone app to upload the activity to server
        let filename = defaultFilename(prefix: "first-half")
        let gpxString = self.map.exportToGPXString()
        GPXFileManager.save(filename, gpxContents: gpxString)
        
        gpxTrackingStatus = .paused
        sendActivationMessage()
    }

    @objc private func firstHalfEnding(notification: NSNotification) {
        gpxTrackingStatus = .paused
        healthStore.stop(query)
        sceneInterface.isPaused = true
    }
    
    @objc private func secondHalfStarted(notification: NSNotification) {
        gpxTrackingStatus = .tracking
    }
    
    func sendActivationMessage() {
        if session?.activationState == .activated && session?.isReachable ?? false {
            session?.sendMessage(["Watch Message" : "Activate"], replyHandler: {
                (reply) in
                
                if reply["Phone Message"] as! String == "Activated" {
                    self.sendLatesGPXFiletoiOSApp()
                }
            }, errorHandler: { (error) in
                
                print("***** Error Did Occur: \(error) *****")
                self.sendActivationMessage()
            })
        } else {
            print("***** Activation Error *****")
            sendActivationMessage()
        }
    }
    
    func sendLatesGPXFiletoiOSApp() {
        // Transfer gpx file to the iOS app
        guard let gpxFileInfo = GPXFileManager.fileList.first else {
            print("[Debug]: gpx file doesn't exist")
            return
        }
        
        DispatchQueue.global().async {
            print("[Debug]: activationState \(self.session?.activationState)")
            self.session?.transferFile(gpxFileInfo.fileURL, metadata: ["fileName": "\(gpxFileInfo.fileName).gpx"])
        }
    }
    
    ///
    /// Checks the location services status
    /// - Are location services enabled (access to location device wide)? If not => displays an alert
    /// - Are location services allowed to this app? If not => displays an alert
    ///
    /// - Seealso: displayLocationServicesDisabledAlert, displayLocationServicesDeniedAlert
    ///
    func checkLocationServicesStatus() {
        //Are location services enabled?
        if !CLLocationManager.locationServicesEnabled() {
//            gpxTrackingStatus = .paused
            displayLocationServicesDisabledAlert()
            return
        } else {
//            gpxTrackingStatus = .tracking
        }
        
        //Does the app have permissions to use the location servies?
        if !([.authorizedAlways, .authorizedWhenInUse].contains(CLLocationManager.authorizationStatus())) {
//            gpxTrackingStatus = .tracking
            displayLocationServicesDeniedAlert()
            return
        } else {
//            gpxTrackingStatus = .tracking
        }
    }
    
    ///
    /// Displays an alert that informs the user that location services are disabled.
    ///
    /// When location services are disabled is for all applications, not only this one.
    ///
    func displayLocationServicesDisabledAlert() {
        let button = WKAlertAction(title: "Cancel", style: .cancel) {
            print("LocationServicesDisabledAlert: cancel pressed")
        }
        
        presentAlert(withTitle: NSLocalizedString("LOCATION_SERVICES_DISABLED", comment: "no comment"),
                     message: NSLocalizedString("ENABLE_LOCATION_SERVICES", comment: "no comment"),
                     preferredStyle: .alert, actions: [button])
    }
    
    ///
    /// Displays an alert that informs the user that access to location was denied for this app (other apps may have access).
    /// It also dispays a button allows the user to go to settings to activate the location.
    ///
    func displayLocationServicesDeniedAlert() {
        if isDisplayingLocationServicesDenied {
            return // display it only once.
        }
        let button = WKAlertAction(title: "Cancel", style: .cancel) {
            print("LocationServicesDeniedAlert: cancel pressed")
        }
        
        presentAlert(withTitle: NSLocalizedString("ACCESS_TO_LOCATION_DENIED", comment: "no comment"),
                     message: NSLocalizedString("ALLOW_LOCATION", comment: "no comment"),
                     preferredStyle: .alert, actions: [button])
    }
}

// MARK: - StopWatchDelegate

extension TrackingInterfaceController: StopWatchDelegate {
    
    func stopWatch(_ stropWatch: StopWatch, didUpdateElapsedTimeString elapsedTimeString: String) {
        timeLabel.setText(elapsedTimeString)
    }
}

// MARK: - CLLocationManagerDelegate

extension TrackingInterfaceController: CLLocationManagerDelegate {
    
    ///
    /// Updates location accuracy and map information when user is in a new position
    ///
    ///
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //updates signal image accuracy
        let newLocation = locations.first!
        
        let hAcc = newLocation.horizontalAccuracy
        let vAcc = newLocation.verticalAccuracy
        print("didUpdateLocation: received \(newLocation.coordinate) hAcc: \(hAcc) vAcc: \(vAcc) floor: \(newLocation.floor?.description ?? "''")")
        
        if hAcc < kSignalAccuracy6 {
            print("Got kSignalAccuracy6")
//            userMovementLabel.setText("kSignalAccuracy6 strongest")
            trackLocation(newLocation)
        } else if hAcc < kSignalAccuracy5 {
            print("Got kSignalAccuracy5")
//            userMovementLabel.setText("kSignalAccuracy5")
            trackLocation(newLocation)
        } else if hAcc < kSignalAccuracy4 {
            print("Got kSignalAccuracy4")
//            userMovementLabel.setText("kSignalAccuracy4")
        } else if hAcc < kSignalAccuracy3 {
            print("Got kSignalAccuracy3")
//            userMovementLabel.setText("kSignalAccuracy3")
        } else if hAcc < kSignalAccuracy2 {
            print("Got kSignalAccuracy2")
//            userMovementLabel.setText("kSignalAccuracy2")
        } else if hAcc < kSignalAccuracy1 {
            print("Got kSignalAccuracy1")
//            userMovementLabel.setText("kSignalAccuracy1")
        } else {
            print("Got the worst signal")
//            userMovementLabel.setText("worst signal")
        }
        
        print("Hey Whatever.....")
    }
    
    private func trackLocation(_ newLocation: CLLocation) {
        //        print("Motion State -- x: \(motionManager.accelerometerData?.acceleration.x) y: \(motionManager.accelerometerData?.acceleration.y) z: \(motionManager.accelerometerData?.acceleration.z)")
        //        var isUserMoving = false
        //        if let accelerometerData = motionManager.accelerometerData {
        //            if accelerometerData.acceleration.x > 1.5 && accelerometerData.acceleration.y > 1.5 {
        //                //                userMovementLabel.setText("Moving")
        //                isUserMoving = true
        //            } else {
        //                //                userMovementLabel.setText("Not Moving")
        //                isUserMoving = false
        //            }
        //        }
        
        // Update speed (provided in m/s, but displayed in km/h)
        if newLocation.speed > 0.5 {
            speedLabel.setText(newLocation.speed.toSpeed(useImperial: preferences.useImperial))
            
            if gpxTrackingStatus == .tracking {
                print("didUpdateLocation: adding point to track (\(newLocation.coordinate.latitude),\(newLocation.coordinate.longitude))")
                map.addPointToCurrentTrackSegmentAtLocation(newLocation)
                totalTrackedDistanceLabel.setText(map.totalTrackedDistance.toDistance(useImperial: preferences.useImperial))
                //currentSegmentDistanceLabel.distance = map.currentSegmentDistance
            }
        }
    }
}


// MARK: - Helpers

extension TrackingInterfaceController {
    
    /// returns a string with the format of current date dd-MMM-yyyy-HHmm' (20-Jun-2018-1133)
    ///
    func defaultFilename(prefix: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = prefix + "dd-MMM-yyyy-HHmm"
        print("fileName:" + dateFormatter.string(from: Date()))
        return dateFormatter.string(from: Date())
    }
    
    func autorizeHealthKit() {
        // Used to define the identifiers that create quantity type objects.
        let healthKitTypes: Set = [
            HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifier.heartRate)!]
        // Requests permission to save and read the specified data types.
        healthStore.requestAuthorization(toShare: healthKitTypes, read: healthKitTypes) { _, _ in }
    }
}

// MARK: WCSessionDelegate

///
/// Handles all the file transfer to iOS app processes
///
extension TrackingInterfaceController: WCSessionDelegate {
    
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        let prefixText = "GPXFileTableInterfaceController:: activationDidCompleteWithActivationState:"
        switch activationState {
        case .activated:
            print("\(prefixText) session activated")
        case .inactive:
            print("\(prefixText) session inactive")
        case .notActivated:
            print("\(prefixText) session not activated, error:\(String(describing: error))")
            
        default:
            print("\(prefixText) default, error:\(String(describing: error))")
        }
    }
    
    func session(_ session: WCSession, didFinish fileTransfer: WCSessionFileTransfer, error: Error?) {
        let doneAction = WKAlertAction(title: NSLocalizedString("DONE", comment: "no comment"), style: .default) { }
        guard let error = error else {
            print("WCSession: didFinish fileTransfer: \(fileTransfer.file.fileURL.absoluteString)")
            // presenting success indicator to user if file is successfully transferred
            // will only present once all files are sent (if multiple in queue)
            if session.outstandingFileTransfers.count == 1 {
                print("GPX file transfered successfully")
                gpxTrackingStatus = .notStarted
                WKInterfaceController.reloadRootPageControllers(
                    withNames: ["settings", "gameOptions"],
                    contexts: nil,
                    orientation: .horizontal,
                    pageIndex: 1)
            }
            return
        }
        
        // presents indicator first, if file transfer failed, without error message
        print("Failure while transfering GPX file")
        
        
        // presents alert after 1.5s, with error message
        // MARK: "as CVarArg" was suggested by XCode and my intruduce a bug...
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.presentAlert(withTitle: NSLocalizedString("ERROR_OCCURED_TITLE", comment: "no comment"),
                              message: String(format: NSLocalizedString("ERROR_OCCURED_MESSAGE", comment: "no comment"), error as CVarArg),
                              preferredStyle: .alert, actions: [doneAction])
        }
    }
    
}

// MARK: - Heart rate monitoring

private extension TrackingInterfaceController {
    
    func startHeartRateQuery(quantityTypeIdentifier: HKQuantityTypeIdentifier) {
        // We want data points from our current device
        let devicePredicate = HKQuery.predicateForObjects(from: [HKDevice.local()])
        
        // A query that returns changes to the HealthKit store, including a snapshot of new changes and continuous monitoring as a long-running query.
        let updateHandler: (HKAnchoredObjectQuery, [HKSample]?, [HKDeletedObject]?, HKQueryAnchor?, Error?) -> Void = {
            query, samples, deletedObjects, queryAnchor, error in
            
            // A sample that represents a quantity, including the value and the units.
            guard let samples = samples as? [HKQuantitySample] else {
                return
            }
            
            self.process(samples, type: quantityTypeIdentifier)
            
        }
        
        // It provides us with both the ability to receive a snapshot of data, and then on subsequent calls, a snapshot of what has changed.
        query = HKAnchoredObjectQuery(type: HKObjectType.quantityType(forIdentifier: quantityTypeIdentifier)!, predicate: devicePredicate, anchor: nil, limit: HKObjectQueryNoLimit, resultsHandler: updateHandler)
        
        query.updateHandler = updateHandler
        
        // query execution
        
        healthStore.execute(query)
    }
    
    func process(_ samples: [HKQuantitySample], type: HKQuantityTypeIdentifier) {
        // variable initialization
        var lastHeartRate = 0.0
        
        // cycle and value assignment
        for sample in samples {
            if type == .heartRate {
                lastHeartRate = sample.quantity.doubleValue(for: heartRateQuantity)
            }
            
            heartRateValueLabel.setText("\(Int(lastHeartRate))")
        }
    }
}

// MARK: - Motion detection

extension TrackingInterfaceController {
    
    func startMotionUpdates() {
        pedometer.startUpdates(from: Date(), withHandler: { (pedometerData, error) in
            if let pedData = pedometerData {
                print("numberOfSteps: \(Int(pedData.numberOfSteps))")
                //self.stepsLabel.text = "Steps:\(pedData.numberOfSteps)"
                if let distance = pedData.distance {
                    print("distance: \(Double(distance))")
                }
                
                if let averageActivePace = pedData.averageActivePace {
                    print("averagePace: \(Double(averageActivePace))")
                }
                
                if let currentPace = pedData.currentPace {
                    print("currentPace: \(Double(currentPace))")
                    
//                    self.userMovementLabel.setText("Pace: \(Double(currentPace))")
                    
                    if currentPace == 0 {
                        self.isDeviceMoving = false
                    } else {
                        self.isDeviceMoving = true
                    }
                }
            } else {
                print("numberOfSteps unknown")
            }
        })
    }
}
