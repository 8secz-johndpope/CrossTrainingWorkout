//
//  AthleteCell.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import ListDataSourcesKit

class AthleteCell: UITableViewCell, ConfigurableNibReusableCell {
    
    typealias Model = AthleteCellViewModel
    typealias CellView = UITableView
    
    @IBOutlet weak var fullNameLabel: UILabel!
    
    override func didMoveToSuperview() {
        self.selectionStyle = .none
    }
    
    func configure(withModel model: AthleteCellViewModel) {
        self.fullNameLabel.text = model.fullName
    }
}
