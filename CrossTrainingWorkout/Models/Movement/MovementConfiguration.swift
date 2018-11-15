//
//  MovementConfiguration.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation
import RealmSwift

class MovementConfiguration: Object, Codable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    @objc dynamic var id: String! = ""
    @objc dynamic var movement: Movement?
    @objc dynamic var amount = 0
    
    let wod = LinkingObjects(fromType: Wod.self, property: "movements")
    
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
        guard let mov = movement else { return "" }
        return "\(mov) x \(amount)"
    }
}
