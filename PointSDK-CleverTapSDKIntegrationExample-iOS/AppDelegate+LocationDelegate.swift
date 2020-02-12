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

extension AppDelegate: BDPLocationDelegate {
    func didUpdateZoneInfo(_ zoneInfos: Set<AnyHashable>!) {
        print("Zone information has been recieved")
    }
    
    func didCheck(intoFence fence: BDFenceInfo!,
                  inZone zoneInfo: BDZoneInfo!,
                  atLocation location: BDLocationInfo!,
                  willCheckOut: Bool,
                  withCustomData customData: [AnyHashable : Any]!
    ) {
        
        // Name the custom event
        let customEventName = "bluedot_entry"
        
        // Map the Location and Zone attributes into a properties dictionary
        var properties = [
            "bluedot_zone_id": "\(zoneInfo.id!)",
            "bluedot_zone_name": "\(zoneInfo.name!)"
        ]
        
        // Map the Custom Data attributes into properties
        if customData != nil && !customData.isEmpty {
            customData.forEach { data in properties["\(data.key)"] = "\(data.value)"}
        }
        
        // Log the Custom Event in CleverTap
        CleverTap.sharedInstance()?.recordEvent(customEventName, withProps: properties)
    }
    
    func didCheckOut(fromFence fence: BDFenceInfo!,
                     inZone zoneInfo: BDZoneInfo!,
                     on date: Date!,
                     withDuration checkedInDuration: UInt,
                     withCustomData customData: [AnyHashable : Any]!
    ) {
        
    }
}
