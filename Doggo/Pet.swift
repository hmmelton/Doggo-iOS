//
//  Pet.swift
//  Doggo
//
//  Created by Harrison Melton on 11/12/16.
//  Copyright © 2016 Harrison Melton. All rights reserved.
//

import Foundation
struct Pet {
    var id: Int32
    var shelterId: String
    var name: String
    var animal: String
    var breeds: [String]
    var mix: Bool
    var age: String
    var sex: Character
    var size: String
    var option: [String]
    var description: String
    var status: Character
    var photos: [Int : String] // Int is for the size of the picture, String is for the URL
    var contact: Contact
}

struct Contact {
    var address1, address2, city, state, phone, fax, email: String
    var zip: Int32
}
