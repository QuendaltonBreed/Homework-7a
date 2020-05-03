//
//  ViewController.swift
//  Homework 7a
//
//  Created by Brendan Reed on 4/28/20.
//  Copyright © 2020 Brendan Reed. All rights reserved.
//



//************************************************************//
// BUILT FOR SIMULATION ON iPhone 11 Pro Max
//************************************************************//

import UIKit
import CoreLocation     // Enable GPS service

class ViewController: UIViewController, CLLocationManagerDelegate {

    
    @IBOutlet weak var locationLabel: UILabel!  // Link to locationLabel
    
    let locManager: CLLocationManager = CLLocationManager()     // location manager calls CLLocationManager
    
    var start: CLLocation!
    
    let mountLong: CLLocationDegrees = 46.8516          // Longitude for the summit of Mount Rainier
    
    let mountLat: CLLocationDegrees = -121.7562         // Latitude
    
    
    
    
    // locationManager function which calls the GPS array for CLLocationManager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        
           let newLocation: CLLocation=locations[0]     // Access entry 0
           NSLog("Getting location.")
           
        
           if newLocation.horizontalAccuracy >= 0 {     // Failure if not 0
            
            // variable mount equals the location of mountLat and mountLong in coordinate degrees
             let mount:CLLocation = CLLocation(latitude: mountLat,longitude: mountLong)
            
                        // CLLocation calls distance(from: ) which uses newest entry from locations[0]
                       let delta:CLLocationDistance = mount.distance(from: newLocation)
                       
                        // conversion
                       let miles: Double = (delta * 0.000621371) + 0.5
        
            
            
            //************************************************************//
            //************************************************************//
            /* PROGRAM ALWAYS ENTERS THIS LOOP. DOES NOT CRASH THE PROGRAM,
               PERHAPS THERE IS SOMETHING WRONG WITH MY SIMULATOR.
               I'VE BEEN TRYING TO CORRECT THIS BUT CANNOT TELL WHAT IS
               CAUSING THIS ISSUE. */
            //************************************************************//
            //************************************************************//
            
            if miles < 3    {
                //locationManager.stopUpdatingLocation()
                locationLabel.text = "Welcome to\n Mount Rainier!"
            }
            
                
            else    {
               
                // Format distance in miles to look appropriate
                let commaDelimited: NumberFormatter = NumberFormatter()
                commaDelimited.numberStyle = NumberFormatter.Style.decimal
                locationLabel.text = commaDelimited.string(from: NSNumber(value: miles))!
                
            }
            
        }
        else {
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyThreeKilometers     // Low accuracy
        locManager.distanceFilter = 1609;                                   // Miles
        locManager.requestWhenInUseAuthorization()                          // Request permission from manager
        locManager.startUpdatingLocation()
        start = nil
    }

}

