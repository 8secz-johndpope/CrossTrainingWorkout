//
//  AthletesListViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 18/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import RealmSwift

struct AthletesListLogicController: AppDependent {
    
    weak var tableView: UITableView!
    
    init(tableView: UITableView) {
        self.tableView = tableView
        self.dataHandler = AhtleteEntityDataHandler(forTableView: self.tableView)
    }
    
    private(set) var dataHandler: AhtleteEntityDataHandler
    
}

class AthletesListViewController: UIViewController, CommonStateTransitionable {
    
    internal var shownViewController: UIViewController?
    
    // **************************************************************
    // MARK: - Athletes List View Controller State
    // **************************************************************
    
    enum AthletesListViewControllerState {
        case consulting
        case newAthlete
        case results
    }
    
    // **************************************************************
    // MARK: - Private Variables
    // **************************************************************
    
    private var logicController: AthletesListLogicController!
    
    private var heightConstraint: NSLayoutConstraint?
    
    private var state: AthletesListViewControllerState!
    
    // **************************************************************
    // MARK: - Outlets
    // **************************************************************
    
    @IBOutlet weak var addButtonContainer: UIView!
    
    @IBOutlet weak var newAthleteViewContainer: UIView! {
        didSet {
            self.heightConstraint = newAthleteViewContainer.heightAnchor.constraint(equalToConstant: 0)
            self.heightConstraint?.isActive = true
        }
    }
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet var addAthleteButton: UIButton!
    
    // **************************************************************
    // MARK: - Life Cycle
    // **************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchAthletes()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewInsets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        navigationItem.backBarButtonItem?.title = ""
        if let newAthleteVC = segue.destination as? NewAthleteViewController {
            
            newAthleteVC.navigationItem.title = "^d pzeddzed"
            
            segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
            newAthleteVC.dutyEndedBlock = { (_) in
                
                DispatchQueue.main.async {
                    self.heightConstraint?.isActive = true
                    UIView.animate(withDuration: 0.3, animations: {
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }

    // **************************************************************
    // MARK: - Private Business
    // **************************************************************
    
    /// 🚧 Setting up controller
    private func setup() {
        
        logicController = AthletesListLogicController(tableView: self.tableView)
        tableView.delegate = self
        
        transition(to: .consulting, animate: false)
    }
    
    /// ⬇️ Fetch athletes from server
    private func fetchAthletes() {
        //FIXME: Retrieve athletes from server
    }
    
    /// 🔄 Update table view insets
    private func updateTableViewInsets() {
        
        let height = max(addButtonContainer.frame.height + 10, newAthleteViewContainer.frame.height)
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -height)
    }
    
    /// ↔️ Transition to a specific state
    ///
    /// - Parameters:
    ///   - state: state to transition to
    ///   - animate: should animate transition (default is false)
    private func transition(to state: AthletesListViewControllerState, animate: Bool=true) {
        
        switch state {
        case .consulting:
            heightConstraint?.isActive = true
            UIView.animate(withDuration: animate ? 0.3 : 0, animations: {
                self.view.layoutIfNeeded()
            })
        case .newAthlete:
            heightConstraint?.isActive = false
            UIView.animate(withDuration: animate ? 0.3 : 0, animations: {
                self.view.layoutIfNeeded()
            })
        case .results:
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "resultsSegue", sender: nil)
            }
        }
    }
    
    // **************************************************************
    // MARK: - User Interaction
    // **************************************************************
    
    /// 👆 Handles when user want's to add a new athlete
    ///
    /// - Parameter sender: _
    @IBAction func addNewAthlete(_ sender: Any) {
        transition(to: .newAthlete)
    }
}

extension AthletesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        transition(to: .results)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Suppr") { [weak self] (action, indexPath) in
            
            guard let athlete = self?.logicController.dataHandler.dataProvider?.item(atIndexPath: indexPath) else {
                self?.transition(toCommonState: .failure("Error while removing user"))
                return
            }
            
            do {
                try self?.logicController.database.delete(athlete)
            } catch {
                self?.transition(toCommonState: .failure(error.localizedDescription))
            }
        }
        
        return [deleteAction]
    }
    
}



