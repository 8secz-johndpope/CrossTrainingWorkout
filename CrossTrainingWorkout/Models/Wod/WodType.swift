//
//  WodType.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

enum WodType: String {
    
    case amrap
    case forTime
    case finisher
    case emom
    
    var color: UIColor {
        
        guard let color = UIColor(named: String(describing: self.rawValue)) else { fatalError("No color defined for this type") }
        return color
    }
    
    var title: String {
        switch self {
        case .amrap:
            return "AMRAP"
        case .forTime:
            return "For time"
        case .emom:
            return "EMOM"
        case .finisher:
            return "Finisher"
        }
    }
}
