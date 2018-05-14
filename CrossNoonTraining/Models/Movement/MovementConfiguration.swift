//
//  MovementConfiguration.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class MovementConfiguration: Object, Mappable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var movement: Movement?
    var amount: Int?
    
    // **************************************************************
    // MARK: - Realm
    // **************************************************************
    
//    override class func primaryKey() -> String? {
//        return "username"
//    }
    
    // **************************************************************
    // MARK: - ObjectMapper
    // **************************************************************
    
    required convenience init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        
    }
    
    override var description: String {
        guard let mov = movement, let am = amount else { return "" }
        return "\(mov) x \(am)"
    }
}
