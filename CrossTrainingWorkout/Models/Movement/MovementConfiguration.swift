//
//  MovementConfiguration.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift

class MovementConfiguration: Object, Codable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var movement: Movement?
    var amount: Int?
    
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
        guard let mov = movement, let am = amount else { return "" }
        return "\(mov) x \(am)"
    }
}
