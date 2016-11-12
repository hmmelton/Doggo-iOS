//
//  FirstViewController.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class FirstViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parameters: Parameters = ["key" : Config.API_KEY, "animal" : "dog", "format" : "json"]
        
        Alamofire.request((Config.BASE_ENDPOINT + "/breed.list"), method: HTTPMethod.get, parameters: parameters)
            .validate()
            .responseString { response in
                switch 
            }
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

