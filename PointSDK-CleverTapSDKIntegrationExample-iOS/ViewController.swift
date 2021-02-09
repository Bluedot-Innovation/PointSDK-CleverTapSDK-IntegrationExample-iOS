//
//  ViewController.swift
//  PointSDK-CleverTapSDKIntegrationExample-iOS
//
//  Created by Ram Akunuru on 12/2/2020.
//  Copyright © 2020 Bluedot Innovation. All rights reserved.
//

import UIKit
import UserNotifications
import BDPointSDK

let projectId = "YourProjectId";

class ViewController: UIViewController {
    @IBOutlet weak var initializeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BDLocationManager.instance()?.requestWhenInUseAuthorization()
    }
    
    @IBAction func startGeoTriggering(_ sender: UIButton) {
        BDLocationManager.instance()?.startGeoTriggering() { error in
            guard error == nil else {
                self.showAlert(title: "Start Geotriggering error", message: error!.localizedDescription)
                return
            }
            
            print("Geotriggering Started")
        }
    }
    
    @IBAction func stopGeoTriggering(_ sender: UIButton) {
        BDLocationManager.instance()?.stopGeoTriggering() { error in
            guard error == nil else {
                self.showAlert(title: "Stop Geotriggering error", message: error!.localizedDescription)
                return
            }
            
            print("Geotriggering Stopped")
        }
    }
    
    @IBAction func initializePointSDK(_ sender: UIButton) {
        
        if BDLocationManager.instance()?.isInitialized() == false {
            BDLocationManager.instance()?.initialize(withProjectId: projectId) {
                error in
                guard error == nil else {
                    self.showAlert(title: "SDK Initialization error",  message: error!.localizedDescription)
                    return
                }
                 
                print("SDK Initialized")
                BDLocationManager.instance()?.requestAlwaysAuthorization()
            }
        }
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
