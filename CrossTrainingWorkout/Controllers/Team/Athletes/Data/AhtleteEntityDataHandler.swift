//
//  AhtleteEntityDataHandler.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit

class AhtleteEntityDataHandler: RealmEntityDataHandler<UITableView, Athlete, AthleteCell> {
    
    override func buildViewModel(withEntity entity: Athlete) -> AthleteCell.Model {
        return AthleteCellViewModel(firstName: entity.firstName, lastName: entity.lastName)
    }
    
}
