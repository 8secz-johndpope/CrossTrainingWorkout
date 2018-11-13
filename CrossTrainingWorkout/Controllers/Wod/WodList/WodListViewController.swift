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

class WodListViewController: UIViewController, CommonStateTransitionable {
    
    // **************************************************************
    // MARK: - Outlets
    // **************************************************************
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.register(WodCell.nib, forCellReuseIdentifier: WodCell.nibName)
        }
    }
    
    @IBOutlet var addAthleteButton: UIButton!
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    weak var delegate: WodListViewControllerDelegate?
    
    private var logicController: WodListLogicController!
    
    // **************************************************************
    // MARK: - Life Cycle
    // **************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        logicController = WodListLogicController(tableView: self.tableView)
    }
    
    // **************************************************************
    // MARK: - Public business
    // **************************************************************
    
    public func updateTableViewPredicate(_ predicate: NSPredicate) {
        
        logicController.dataHandler.predicate = predicate
        do {
            try logicController.dataHandler.fetch()
            tableView.reloadData()
        } catch {
            transition(toCommonState: .failure(error.localizedDescription))
        }
    }
    
    /// 🔄 Update table view insets
    public func updateTableViewInsets(withHeight height: CGFloat) {
        
        let height = max(height, addAthleteButton.frame.height + 15)
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -height)
    }
    
    // **************************************************************
    // MARK: - User Interactions
    // **************************************************************
    
    /// 👆 Handles when user want's to add a new athlete
    ///
    /// - Parameter sender: _
    @IBAction func addNewAthlete(_ sender: Any) {
        delegate?.didAskForNewWod()
    }
    
}

protocol WodListViewControllerDelegate: class {
    func didAskForNewWod()
}
