//
//  Athlete.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift

class Athlete: Object, Codable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    @objc dynamic var id = ""
    @objc dynamic var firstName = ""
    @objc dynamic var lastName = ""
    @objc dynamic var email = ""
    @objc dynamic var age = 0
    
    var fullName: String {
        return firstName
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
