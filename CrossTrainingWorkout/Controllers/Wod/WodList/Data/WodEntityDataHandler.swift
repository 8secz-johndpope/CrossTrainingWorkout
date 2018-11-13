//
//  AhtleteEntityDataHandler.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit

class WodEntityDataHandler: RealmEntityDataHandler<UITableView, Wod, WodCell> {
    
    override func buildViewModel(withEntity entity: Wod) -> WodCellViewModel {
        return WodCellViewModel(name: entity.name)
    }
}
