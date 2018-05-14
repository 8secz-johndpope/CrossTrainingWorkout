//
//  RoundResult.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class RoundResult: Result, Resultable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var repetitions: Int!
    var rounds: Int!
    
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
    
    override func mapping(map: Map) {
        
    }
    
    var resultRepresentation: String {
        return "\(repetitions) + \(rounds)"
    }
}
