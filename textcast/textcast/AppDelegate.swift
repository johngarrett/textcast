//
//  AppDelegate.swift
//  textcast
//
//  Created by John Garrett on 5/27/19.
//  Copyright © 2019 John Garrett. All rights reserved.
//

import UIKit
import GoogleCast

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    let kReceiverAppID = kGCKDefaultMediaReceiverApplicationID
    let kDebugLoggingEnabled = true
    
    var window: UIWindow?
    
    func applicationDidFinishLaunching(_ application: UIApplication) {
        let criteria = GCKDiscoveryCriteria(applicationID: kReceiverAppID)
        let options = GCKCastOptions(discoveryCriteria: criteria)
        GCKCastContext.setSharedInstanceWith(options)
        
        // Enable logger
        GCKLogger.sharedInstance().delegate = self
    }
}

extension AppDelegate: GCKLoggerDelegate{
    func logMessage(_ message: String,
                    at level: GCKLoggerLevel,
                    fromFunction function: String,
                    location: String) {
        if (kDebugLoggingEnabled) {
            print(function + " - " + message)
        }
    }
}
