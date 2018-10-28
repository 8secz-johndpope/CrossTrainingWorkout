//
//  Movement.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift

class Movement: Object, Codable {
    
    // **************************************************************
    // MARK: - Enums
    // **************************************************************
    
    enum MovementCategory: Int, Codable {
        case weightLifting, bodyWeight, endurance
    }
    
    // **************************************************************
    // MARK: - Enums
    // **************************************************************
    
    enum MovementAmoutType: Int, Codable {
        
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
    // MARK: - Encodable
    // **************************************************************
    
    func encode(to encoder: Encoder) throws {
        
    }
    
    // **************************************************************
    // MARK: - Decodable
    // **************************************************************
    
    public required convenience init(from decoder: Decoder) throws {
        self.init()
//        name <- map["name"]
//        amountType <- map["amountType"]
//        categories <- map["categories"]
    }
    
}
