//
//  WodCell.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 13/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import ListDataSourcesKit

class WodCell: UITableViewCell, ConfigurableNibReusableCell {
    
    typealias Model = WodCellViewModel
    typealias CellView = UITableView
    
    @IBOutlet weak var wodNameLabel: UILabel!
    
    override func didMoveToSuperview() {
        self.selectionStyle = .none
    }
    
    func configure(withModel model: WodCellViewModel) {
        self.wodNameLabel.text = model.name
    }
}
