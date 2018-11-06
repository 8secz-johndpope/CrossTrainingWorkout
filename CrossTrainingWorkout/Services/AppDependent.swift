//
//  AppDependent.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol AppDependent {}
extension AppDependent {
    
    var database: Database {
        return App.shared.database
    }
}
