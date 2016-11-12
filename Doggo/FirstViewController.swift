//
//  FirstViewController.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import UIKit
import Alamofire
import AEXML
import CoreLocation

class FirstViewController: UIViewController, CLLocationManagerDelegate {

    var location = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        
        // Location is currently hardcoded, due to GPS problems with emulator
        let parameters: Parameters = ["key" : Config.API_KEY, "animal" : "dog", "location" : "98029", "count" : 20]
        
        Alamofire.request((Config.BASE_ENDPOINT + "/pet.find"), method: HTTPMethod.get, parameters: parameters)
            .validate()
            .responseString { response in
                switch response.result {
                case .success:
                    // Call made successfully
                    if let value = response.result.value {
                        // Value was pulled from response
                        do {
                            let xmlDoc = try AEXMLDocument(xml: value)
                            print(xmlDoc.xml)
                            if let 🐶🐶 = xmlDoc.root["pets"]["pet"].all {
                                // Add each doge to 
                                for 🐶 in 🐶🐶 {
                                    Pet(data: 🐶)
                                }
                            } else {
                                // XML path was null
                                print("\n\n\n error fetching doges \n\n\n\n")
                            }
                        } catch {
                            print("\n\n\n \(error) \n\n\n")
                        }
                    } else {
                        // No value was pulled from response
                        print("\n\n\n\n\n no value \n\n\n\n")
                    }
                case .failure(let error):
                    // Call was not made successfully
                    print("\n\n\n\n \(error.localizedDescription) \n\n\n\n")
                }
            }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Location Functions
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if placemarks!.count == 0 {
                let pm = (placemarks![0]) as? CLPlacemark
                self.displayLocationInfo(placemark: pm!)
            } else {
                print("Problem with the data received from geocoder")
            }
        })
    }
    
    private func locationManager(manager: CLLocationManager!, didFailWithError error: NSError!) {
        print("Error while updating location " + error.localizedDescription)
    }
    
    func displayLocationInfo(placemark: CLPlacemark) {
        //stop updating location to save battery life
        location.stopUpdatingLocation()
        print((placemark.locality != nil) ? placemark.locality! : "")
        print((placemark.postalCode != nil) ? placemark.postalCode! : "")
        print((placemark.administrativeArea != nil) ? placemark.administrativeArea! : "")
        print((placemark.country != nil) ? placemark.country! : "")
    }

}

