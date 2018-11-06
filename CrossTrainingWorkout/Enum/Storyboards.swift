//
//  Storyboards.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 05/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

enum Storyboards: String {
    
    case main
    case team
    case wod
    case history
    
    func instantiate<T: UIViewController>(withType type: T.Type) -> T {
        let bundle = Bundle.main
        let storyboard = UIStoryboard.init(name: self.rawValue.capitalized, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
