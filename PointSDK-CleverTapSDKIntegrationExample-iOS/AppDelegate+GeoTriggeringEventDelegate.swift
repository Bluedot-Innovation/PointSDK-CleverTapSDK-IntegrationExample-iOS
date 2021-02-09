//
//  AppDelegate+LocationDelegate.swift
//  PointSDK-CleverTapSDKIntegrationExample-iOS
//
//  Created by Ram Akunuru on 12/2/2020.
//  Copyright © 2020 Bluedot Innovation. All rights reserved.
//

import Foundation
import BDPointSDK
import CleverTapSDK

extension AppDelegate: BDPGeoTriggeringEventDelegate {
    
    func onZoneInfoUpdate(_ zoneInfos: Set<BDZoneInfo>) {
        print("Zone information has been received")
    }
    
    func didEnterZone(_ enterEvent: BDZoneEntryEvent) {
        print("Entered Zone: \(String(describing: enterEvent.zone().name))")
        // Name the custom event
        let customEventName = "bluedot_entry"
        
        // Map the Location and Zone attributes into a properties dictionary
        var properties = [
            "bluedot_zone_id": "\(enterEvent.zone().id!)",
            "bluedot_zone_name": "\(enterEvent.zone().name!)"
        ]
        
        // Map the Custom Data attributes into properties
        if let custData = enterEvent.zone().customData, !custData.isEmpty {
            custData.forEach { data in properties["\(data.key)"] = "\(data.value)"}
        }
        
        // Log the Custom Event in CleverTap
        CleverTap.sharedInstance()?.recordEvent(customEventName, withProps: properties)
    }
}
