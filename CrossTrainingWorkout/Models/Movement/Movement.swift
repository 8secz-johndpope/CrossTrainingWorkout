//
//  Movement.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Movement: Object, Mappable {
    
    // **************************************************************
    // MARK: - Enums
    // **************************************************************
    
    enum MovementCategory: Int {
        case weightLifting, bodyWeight, endurance
    }
    
    // **************************************************************
    // MARK: - Enums
    // **************************************************************
    
    enum MovementAmoutType: Int {
        
        case meters, repetitions
        
        var format: String {
            switch self {
            case .meters:
                return "m"
            case .repetitions:
                return "reps"
            }
        }
    }
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    @objc dynamic var name = ""
    @objc dynamic var amountType = 0
    
    var categories = List<Int>()
    
    // **************************************************************
    // MARK: - Realm
    // **************************************************************
    
    override class func primaryKey() -> String? {
        return "name"
    }
    
    // **************************************************************
    // MARK: - ObjectMapper
    // **************************************************************
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
        name <- map["name"]
        amountType <- map["amountType"]
        categories <- map["categories"]
    }
    
}
