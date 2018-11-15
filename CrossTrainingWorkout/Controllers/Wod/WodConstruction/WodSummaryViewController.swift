//
//  WodSummaryViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 14/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit
import RealmSwift

struct WodSummaryLogicController: AppDependent {
    
    weak var tableView: UITableView!
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.dataHandler = MovementsEntityDataHandler<UITableView, MovementCell>(forTableView: self.tableView, usingWodId: "1")
    }
    
    private(set) var dataHandler: MovementsEntityDataHandler<UITableView, MovementCell>
}

class WodSummaryViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(MovementCell.nib, forCellReuseIdentifier: MovementCell.nibName)
        }
    }
    
    var logicController: WodSummaryLogicController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController = WodSummaryLogicController(tableView: tableView)
    }
    
}
