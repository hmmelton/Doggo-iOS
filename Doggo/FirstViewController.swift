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

class FirstViewController: UIViewController, CLLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource {

    var location = CLLocationManager()
    var dataSource = [Pet]()
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        
        location.delegate = self
        location.desiredAccuracy = kCLLocationAccuracyBest
        location.requestWhenInUseAuthorization()
        location.startUpdatingLocation()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
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
                            if let 🐶🐶 = xmlDoc.root["pets"]["pet"].all {
                                // Add each doge to 
                                for 🐶 in 🐶🐶 {
                                    self.dataSource.append(Pet(data: 🐶))
                                }
                            } else {
                                // XML path was null
                                print("\n\n\n error fetching doges \n\n\n\n")
                            }
                            self.tableView.reloadData()
                            print("\n\n\n\n \(self.dataSource.count) \n\n\n\n")
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
    
    // This function downloads an image from a URL
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    // MARK: UITableView Functions
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: PetCell = (tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as! PetCell)
        
        cell.nameView.text = self.dataSource[indexPath.row].name

        if self.dataSource[indexPath.row].photos.count > 2 {
            let imageUrl: URL = URL(string: self.dataSource[indexPath.row].photos[2])!
            // Asynchronously get image
            getDataFromUrl(url: imageUrl) { (data, response, error) in
                DispatchQueue.main.async() { () -> Void in
                    if (data != nil && error == nil) {
                        cell.coverImage.image = UIImage(data: data!)
                    }
                }
            }
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("count: \(self.dataSource.count)")
        return self.dataSource.count
    }
    
    
    // MARK: Location Functions
    private func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {(placemarks, error) -> Void in
            if (error != nil) {
                print("Reverse geocoder failed with error" + (error?.localizedDescription)!)
                return
            }
            
            if placemarks!.count == 0 {
                let pm = (placemarks![0]) as CLPlacemark
                self.displayLocationInfo(placemark: pm)
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

