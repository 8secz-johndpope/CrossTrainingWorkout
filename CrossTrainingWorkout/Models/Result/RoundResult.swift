//
//  RoundResult.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation
import RealmSwift

class RoundResult: Result, Resultable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var repetitions: Int!
    var rounds: Int!
    
    // **************************************************************
    // MARK: - Resultable
    // **************************************************************
    
    var resultRepresentation: String {
        return "\(String(describing: repetitions)) + \(String(describing: rounds))"
    }
}
