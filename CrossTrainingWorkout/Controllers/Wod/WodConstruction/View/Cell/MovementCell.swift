//
//  WodCell.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 13/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import ListDataSourcesKit

class MovementCell: UITableViewCell, ConfigurableNibReusableCell {
    
    typealias Model = MovementCellViewModel
    typealias CellView = UITableView
    
    @IBOutlet weak var movementName: UILabel!
    
    override func didMoveToSuperview() {
        self.selectionStyle = .none
    }
    
    func configure(withModel model: MovementCellViewModel) {
        self.movementName.text = model.name
    }
}
