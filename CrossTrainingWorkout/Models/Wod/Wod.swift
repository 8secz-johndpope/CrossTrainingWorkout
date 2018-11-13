//
//  Wod.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation
import RealmSwift

class Wod: Object, Codable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    @objc dynamic var id: String!
    @objc dynamic var name: String!
    var timeCap: TimeInterval!
    @objc dynamic var wodType: String! = ""
    var movements: List<MovementConfiguration>?
    
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
    }
    
    override var description: String {
        return "\(String(describing: name))"
    }
}

