//
//  Pet.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import Foundation
import AEXML

struct Pet {
    var id: Int32
    var shelterId: String
    var name: String
    var animal: String
    var breeds: [String]
    var mix: Bool
    var age: String
    var sex: String
    var size: String
    var options: [String]
    var description: String
    var status: String
    var photos: [String] // Int is for the index of the picture, String is for the URL
    var contact: Contact
    
    init(data: AEXMLElement) {
        self.id = Int32(data["id"].string)!
        self.shelterId = data["shelterId"].string
        self.name = data["name"].string
        self.animal = data["animal"].string
        
        // Parse for all breeds
        self.breeds = [String]()
        if let breeds = data["breeds"]["breed"].all {
            for breed in breeds {
                if let value = breed.value {
                    self.breeds.append(value)
                }
            }
        }
        
        self.mix = data["mix"].bool
        self.age = data["age"].string
        self.sex = data["sex"].string
        self.size = data["size"].string
        
        // Parse for all options
        self.options = [String]()
        if let options = data["options"]["option"].all {
            for option in options {
                if let value = option.value {
                    self.options.append(value)
                }
            }
        }
        
        self.description = data["description"].string
        self.status = data["status"].string
        
        // Parse for all photos of animal
        self.photos = [String]()
        print(data.xml)
        if let dogePhotos = data["media"]["photos"]["photo"].all {
            for photo in dogePhotos {
                if let value = photo.value {
                    self.photos.append(value)
                }
            }
        }
        
        self.contact = Contact(data: data["contact"])
    }
}

// Struct used to hold contact information of animal shelter
struct Contact {
    var address1, address2, city, state, phone, email: String
    var zip: Int32
    
    init (data: AEXMLElement) {
        self.address1 = data["address1"].string
        self.address2 = data["address2"].string
        self.city = data["city"].string
        self.state = data["state"].string
        self.zip = Int32(data["zip"].string)!
        self.phone = data["phone"].string
        self.email = data["email"].string
    }
}
