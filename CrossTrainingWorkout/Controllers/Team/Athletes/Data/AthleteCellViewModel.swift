//
//  AthleteCellViewModel.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

struct AthleteCellViewModel {
    
    var firstName: String
    var lastName: String
    
    var fullName: String {
        return "\(firstName) \(lastName)"
    }
}
