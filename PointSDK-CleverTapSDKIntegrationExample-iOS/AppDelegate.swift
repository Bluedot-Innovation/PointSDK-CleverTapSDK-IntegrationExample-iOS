//
//  AppDelegate.swift
//  PointSDK-CleverTapSDKIntegrationExample-iOS
//
//  Created by Ram Akunuru on 12/2/2020.
//  Copyright © 2020 Bluedot Innovation. All rights reserved.
//

import UIKit
import UserNotifications
import BDPointSDK
import CleverTapSDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    var window: UIWindow?
      
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        // Initiates BDLocationManager
        BDLocationManager.instance()?.geoTriggeringEventDelegate = self
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
        CleverTap.autoIntegrate()
        
        return true
    }
}

