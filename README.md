# CleverTap Custom Event Example

A sample project used to test the integration between CleverTap SDK and Bluedot Point SDK.
## Getting Started

This project depends on `BluedotPointSDK` and `CleverTap-iOS-SDK`. Both dependencies ban be managed by [CocoaPods](https://cocoapods.org/). Please refer to the `Podfile` in the repository.

### Pre-requisite
Install git-lfs and lfs using the below commands:

```
brew install git-lfs

git lfs install
```

### Implement `BluedotPointSDK`

1. import `BDPointSDK` to your class:

**Swift**

```swift
import BDPointSDK
```

2. Implement Bluedot location delegate:

**Swift**
```swift
class YourClass: BDPLocationDelegate {

    func didCheck(
        intoFence fence: BDFenceInfo!,
        inZone zoneInfo: BDZoneInfo!,
        willCheckOut: Bool,
        withCustomData customData: [AnyHashable : Any]!
    ) {
     
        // Your logic when the device enters a Bluedot Zone

    }

    func didCheckOut(
        fromFence fence: BDFenceInfo!,
        inZone zoneInfo: BDZoneInfo!,
        on date: Date!,
        withDuration checkedInDuration: UInt,
        withCustomData customData: [AnyHashable : Any]!
    ) {
        
        // Your logic when the device leaves a Bluedot Zone
        
    }

    // Beacons entry / exit. This is optional, unless beacons are used.
    func didCheck(
        intoBeacon beacon: BDBeaconInfo!,
        inZone zoneInfo: BDZoneInfo!,
        atLocation locationInfo: BDLocationInfo!,
        with proximity: CLProximity,
        willCheckOut: Bool,
        withCustomData customData: [AnyHashable : Any]!
    ) {

        // Your logic when the device enters in the range of beacon in a Bluedot Zone
    }


    func didCheckOut(
        fromBeacon beacon: BDBeaconInfo!,
        inZone zoneInfo: BDZoneInfo!,
        with proximity: CLProximity,
        on date: Date!,
        withDuration checkedInDuration: UInt,
        withCustomData customData: [AnyHashable : Any]! 
    ) {

        // your logic when a devices leaves the range of beacon of a Bluedot Zone

    }

}
```

3. Assign location delegate with your implementation

**Swift**
```swift
let instanceOfYourClass = YourClass()
BDLocationManager.instance()?.locationDelegate = instanceOfYourClass
```

4. Authenticate with the Bluedot services

**Swift**
```swift
BDLocationManager.instance()?.authenticate(withApiKey: "Your assigned Bluedot API Key", requestAuthorization: .authorizedAlways)
```

### Implement `CleverTap SDK`

1. To use the CleverTap iOS SDK, add the CleverTap SDK to your Podfile as shown below.
```
pod "CleverTap-iOS-SDK"
```

**Swift**
```swift
import CleverTapSDK
```

2. Add CleverTap credentials to associate your iOS app with your CleverTap account, you will need to add your CleverTap credentials in the Info.plist file in your application. For further information refer to [CleverTap Developer Documentation](https://developer.clevertap.com/docs/ios-quickstart-guide)

    Navigate to the Info.plist file in your project navigator. First, create a key called CleverTapAccountID with type string.
    Second, create a key called CleverTapToken with type string. Insert the Account ID and Account Token values from your CleverTap account.

3. Import CleverTapSDK to your AppDelegate.swift file.

**Swift**
```swift
func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject:AnyObject]?) -> Bool {
    ...
    CleverTap.autoIntegrate()
    ...
}
```

4. Track `CleverTap` custom events in your Bluedot Entry events.

```swift
func didCheck(
    intoFence fence: BDFenceInfo!,
        inZone zoneInfo: BDZoneInfo!,
        atLocation location: BDLocationInfo!,
        willCheckOut: Bool,
        withCustomData customData: [AnyHashable : Any]!
){
    // Name the custom event 
    let customEventName = "bluedot_entry"

    // Map the Location and Bluedot Zone attributes into a properties dictionary
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

```

## Next steps
Full documentation can be found at https://docs.bluedot.io/ios-sdk/ and https://developer.clevertap.com/docs/ios-quickstart-guide respectivelly.
