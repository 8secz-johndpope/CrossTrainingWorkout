//
//  WodListTableViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 09/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

struct WodListLogicController: AppDependent {
    
    weak var tableView: UITableView!
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.dataHandler = WodEntityDataHandler(forTableView: self.tableView)
    }
    
    private(set) var dataHandler: WodEntityDataHandler
    
}

class WodListViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            print("🎁🎁🎁🎁🎁🎁 \(WodCell.nib)")
            tableView.register(WodCell.nib, forCellReuseIdentifier: "WodCell")
        }
    }
    
    @IBOutlet var addAthleteButton: UIButton!
    
    weak var delegate: WodListViewControllerDelegate?
    
    private var logicController: WodListLogicController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logicController = WodListLogicController(tableView: self.tableView)
    }
    
    /// 👆 Handles when user want's to add a new athlete
    ///
    /// - Parameter sender: _
    @IBAction func addNewAthlete(_ sender: Any) {
        delegate?.didAskForNewWod()
    }
    
    /// 🔄 Update table view insets
    public func updateTableViewInsets(withHeight height: CGFloat) {
        
        let height = max(height, addAthleteButton.frame.height + 15)
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -height)
    }
    
}

protocol WodListViewControllerDelegate: class {
    func didAskForNewWod()
}
