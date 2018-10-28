//
//  TimeResult.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 03/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation
import RealmSwift

class TimeResult: Result, Resultable {
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    var time: TimeInterval!
    
    // **************************************************************
    // MARK: - Resultable
    // **************************************************************
    
    var resultRepresentation: String {
        return String(time)
    }
}
