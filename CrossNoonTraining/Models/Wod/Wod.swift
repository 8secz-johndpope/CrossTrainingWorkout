//
//  Wod.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper
import ObjectMapper_Realm

class Wod: Object {
    
    enum WodType {
        case amrap
        case forTime
        case emom
        case finisher
    }
    
    var id: String!
    var name: String!
    var timeCap: TimeInterval!
    var wodType: WodType!
    var movements: [MovementConfiguration]?
    
    override var description: String {
//        guard let name = name else { return "" }
        return "\(String(describing: name))"
    }
}

