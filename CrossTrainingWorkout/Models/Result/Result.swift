//
//  Result.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Result: Object, Mappable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var athlete: Athlete!
    
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
}
