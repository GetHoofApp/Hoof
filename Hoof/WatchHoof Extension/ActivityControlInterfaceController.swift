//
//  ActivityControlInterfaceController.swift
//  WatchHoof Extension
//
//  Created by Sameh Mabrouk on 08/02/2022.
//

import WatchKit
import Foundation


class ActivityControlInterfaceController: WKInterfaceController {

    @IBOutlet var trackerButton: WKInterfaceButton!
    @IBOutlet var endActivityButton: WKInterfaceButton!

    @IBOutlet var pauseAndResumeLabel: WKInterfaceLabel!
    @IBOutlet var endActivityLabel: WKInterfaceLabel!
    
    enum ActivityState {
        case pasue
        case resume
        case end
        case secondHalf
    }
    
    var activityState: ActivityState = .pasue
    
    var isFirstHalf = true
    var didSecondHalfStarted = false
    var didSecondHalfEnded = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
        NotificationCenter.default.addObserver(self, selector: #selector(positionSelectedForFirstHalf(notification:)), name: .PositionSelectedForFirstHalf, object: nil)
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    @objc private func positionSelectedForFirstHalf(notification: NSNotification) {
        if isFirstHalf {
            pauseAndResumeLabel.setText("2nd half")
            trackerButton.setBackgroundImage(UIImage(named: "start"))
            endActivityLabel.setText("End match")
            endActivityButton.setBackgroundImage(UIImage(named: "end-of-match"))
            
            NotificationCenter.default.post(name: .FirstHalfEnding, object: nil)

            isFirstHalf = false
            activityState = .secondHalf
        } else if !isFirstHalf {
            didSecondHalfEnded = true
        }
    }
    
    @IBAction func pauseAction() {
        if activityState == .pasue {
            activityState = .resume
            trackerButton.setBackgroundImage(UIImage(named: "resume"))
            NotificationCenter.default.post(name: Notification.Name(rawValue: Notification.Name.ActivityPaused), object: nil)
        } else if activityState == .resume {
            activityState = .pasue
            trackerButton.setBackgroundImage(UIImage(named: "pause"))
            NotificationCenter.default.post(name: Notification.Name(rawValue: Notification.Name.ActivityResumed), object: nil)
        } else if activityState == .secondHalf {
            isFirstHalf = false
            didSecondHalfStarted = true
            activityState = .pasue
            trackerButton.setBackgroundImage(UIImage(named: "pause"))
            NotificationCenter.default.post(name: .SecondHalfStarted, object: nil)
        }
    }
        
    @IBAction func endAction() {
//        if isFirstHalf {
//            isFirstHalf = false
//        } else {
////            NotificationCenter.default.post(name: Notification.Name(rawValue: Notification.Name.ActivityEnded), object: nil)
//        }
        if isFirstHalf || (didSecondHalfStarted && !didSecondHalfEnded) {
            presentController(withName: "positionOptions", context: nil)
        } else if !isFirstHalf && !didSecondHalfStarted && !didSecondHalfEnded {
            NotificationCenter.default.post(name: .EndGameWithOnlyFirstHalf, object: nil)
        } else {
            // end game with only first half activity recorded
            NotificationCenter.default.post(name: .ActivityEnded, object: nil)
        }
    }
    
    @IBAction func lockAction() {
        WKInterfaceDevice.current().enableWaterLock()
        NotificationCenter.default.post(name: Notification.Name(rawValue: Notification.Name.WaterLockEnabled), object: nil)
    }
}


