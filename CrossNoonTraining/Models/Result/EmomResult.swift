//
//  EmomResult.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class EmomResult: Result, Resultable {
    
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
    
    // EMOM
    var resultRepresentation: String {
        return ""
    }
}
