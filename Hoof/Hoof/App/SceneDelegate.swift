//
//  SceneDelegate.swift
//  Hoof
//
//  Created by Sameh Mabrouk on 25/10/2021.
//

import UIKit
import RxSwift
import Core
import GoogleMaps
import WatchConnectivity

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    private var rootBuilder = RootBuilder()
    private let disposeBag = DisposeBag()
    private var appRootCoordinator: BaseCoordinator<Void>?
    private let userNotificationCenter = UNUserNotificationCenter.current()
    private let appService = AppService()
	private var lastRecievedFileName: String!

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if let windowScene = scene as? UIWindowScene {
            
            if #available(iOS 9.0, *) {
                if WCSession.isSupported() {
                    print("AppDelegate:: WCSession is supported")
                    let session = WCSession.default
                    session.delegate = self
                    session.activate()
                    print("AppDelegate:: WCSession activated")
                } else {
                    print("AppDelegate:: WCSession is not supported")
                }
            }
            
            let window = UIWindow(windowScene: windowScene)
            self.window = window
            window.makeKeyAndVisible()
            
            appRootCoordinator = rootBuilder.buildModule(with: window)?.coordinator
            guard let appRootCoordinator = appRootCoordinator else {
                preconditionFailure("[SceneDelegate] Cannot get appRootCoordinator from module builder")
            }
            
            Core.setup(with: AppConfig.self)

			FirebaseApp.configure()

            UIUtil.setBasicAppearance()
            
            appRootCoordinator.start()
                .subscribe()
                .disposed(by: disposeBag)
            requestNotificationAuthorization()
        }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        if #available(iOS 9.0, *) {
            if WCSession.isSupported() {
                print("AppDelegate:: WCSession is supported")
                let session = WCSession.default
                session.delegate = self
                session.activate()
                print("AppDelegate:: WCSession activated")
            } else {
                print("AppDelegate:: WCSession is not supported")
            }
        }
    }
}

open class UIUtil {
    
    public static func setBasicAppearance() {
        if #available(iOS 15.0, *) {
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
            UITabBar.appearance().standardAppearance = appearance
            UITabBar.appearance().scrollEdgeAppearance = appearance
            
            let appearance1 = UINavigationBarAppearance()
            appearance1.backgroundColor = .white
            UINavigationBar.appearance().standardAppearance = appearance1
            UINavigationBar.appearance().scrollEdgeAppearance = appearance1
        }
        UITabBar.appearance().isTranslucent = false
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 187/255, green: 187/255, blue: 187/255, alpha: 1.0)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)], for: .selected)
        UITabBar.appearance().tintColor = UIColor(red: 207/255, green: 231/255, blue: 203/255, alpha: 1.0)
    }
}

// MARK: WCSessionDelegate

///
/// Handles file transfers from Apple Watch companion app
/// Should be non intrusive to UI, handling all in the background.

/// File received are automatically moved to default location which stores all GPX files
///
/// Only available > iOS 9
///
@available(iOS 9.0, *)
extension SceneDelegate: WCSessionDelegate {
    
    /// called when `WCSession` goes inactive. Does nothing but display a debug message.
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("AppDelegate:: WCSession has become inactive")
    }
    
    /// called when `WCSession` goes inactive. Does nothing but display a debug message
    func sessionDidDeactivate(_ session: WCSession) {
        print("AppDelegate:: WCSession has deactivated")
    }
    
    /// called when activation did complete. Does nothing but display a debug message.
    @available(iOS 9.3, *)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        switch activationState {
        case .activated:
            print("AppDelegate:: activationDidCompleteWithActivationState: WCSession activated")
        case .inactive:
            print("AppDelegate:: activationDidCompleteWithActivationState: WCSession inactive")
        case .notActivated:
            print("AppDelegate:: activationDidCompleteWithActivationState: WCSession not activated, error:\(String(describing: error))")
            
        default: break
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        
    }
    
    /// Called when a file is received from Apple Watch.
    /// Displays a popup informing about the reception of the file.
    func session(_ session: WCSession, didReceive file: WCSessionFile) {
        // swiftlint:disable force_cast
        let fileName = file.metadata!["fileName"] as! String?
		guard lastRecievedFileName != fileName else { return }

		self.lastRecievedFileName = fileName

        DispatchQueue.global().sync {
            GPXFileManager.moveFrom(file.fileURL, fileName: fileName)
            print("ViewController:: Received file from WatchConnectivity Session")
        }
        
//        // posts notification that file is received from apple watch
//        NotificationCenter.default.post(name: .didReceiveFileFromAppleWatch, object: nil, userInfo: ["fileName": fileName ?? ""])
        
        // Upload activity to server
        if let latestActivity = GPXFileManager.fileList.first {
            print("[DEBUG]: Got the latest activity from storage")

			let timeOfDay = Date().getTimeOfDay()
            appService.uploadActivity(title: timeOfDay, description: "Fun game!", gpxFile: latestActivity).subscribe({ event in
                switch event {
                case .success:
                    print("[DEBUG]: Latest Activity uploaded to server successfully")
					
					// posts notification that file is received from apple watch
					NotificationCenter.default.post(name: .didReceiveFileFromAppleWatch, object: nil, userInfo: ["fileName": fileName ?? ""])
                case .error:
                    print("[DEBUG]: Failure while uploading the latest activity to server")
                    break
                }
            }).disposed(by: self.disposeBag)
        }
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        if let messageFromWatch = message["Watch Message"] {
            let messageData = messageFromWatch as! String
            
            //Message From Watch to Activate Watch Connectivity Session
            if messageData == "Activate" {
                replyHandler(["Phone Message" : "Activated"])
                sendNotification()
            }
        }
    }
}

// MARK: - Notifications

extension SceneDelegate {
    
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions.init(arrayLiteral: .alert, .badge, .sound)
        userNotificationCenter.requestAuthorization(options: authOptions) { (success, error) in
            if let error = error {
                print("Error: ", error)
            }
        }
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        //        notificationContent.title = "Test"
        notificationContent.body = NSLocalizedString("MATCH_READY_TO_UPLOAD", comment: "no comment")
        
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: nil)
        
        userNotificationCenter.add(request) { (error) in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}
