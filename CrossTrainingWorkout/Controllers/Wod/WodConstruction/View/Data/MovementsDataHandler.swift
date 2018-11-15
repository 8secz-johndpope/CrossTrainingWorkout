//
//  MovementsDataHandler.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 14/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import ListDataSourcesKit

class MovementsEntityDataHandler<ListDataView: CellParentViewProtocol, DataCellView: ConfigurableNibReusableCell>: RealmEntityDataHandler<ListDataView, MovementConfiguration, DataCellView> {
    
    override func buildViewModel(withEntity entity: MovementConfiguration) -> DataCellView.Model {
        guard let movement = entity.movement else { fatalError("MovementConfiguration doesn't seem to have an inverse movement") }
        return MovementCellViewModel(name: "\(entity.amount) \(movement.name)") as! DataCellView.Model
    }
    
}

extension MovementsEntityDataHandler where ListDataView == UITableView, DataCellView: UITableViewCell {
    
    convenience init(forTableView tableView: UITableView, usingWodId wodId: String) {
        self.init(forTableView: tableView)
        self.predicate = NSPredicate(format: "ANY wod.id == %@", wodId)
        try? self.fetch()
        tableView.reloadData()
    }
    
}
