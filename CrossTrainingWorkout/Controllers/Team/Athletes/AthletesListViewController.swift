//
//  AthletesListViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 18/02/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import RealmSwift

class AthletesListLogicController: UIViewController {
    
    private var dataHandler: AhtleteEntityDataHandler!
    
}

class AthletesListViewController: UIViewController {
    
    // **************************************************************
    // MARK: - Private Variables
    // **************************************************************
    
    enum AthletesListViewControllerMode {
        case consulting
        case newAthlete
    }
    
    // **************************************************************
    // MARK: - Private Variables
    // **************************************************************
    
    private var dataHandler: AhtleteEntityDataHandler!
    
    private var heightConstraint: NSLayoutConstraint?
    
    private var mode: AthletesListViewControllerMode!
    
    // **************************************************************
    // MARK: - Public Variables
    // **************************************************************
    
    var dutyEndedBlock: ( (Error?) -> Void )?
    
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
        
        dataHandler = AhtleteEntityDataHandler(forTableView: self.tableView)
        tableView.delegate = self
        
        fetchAthletes()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.view.backgroundColor = UIColor(hexString: "#5B708A")
        
        transition(to: .consulting, animate: false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewInsets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        segue.destination.view.translatesAutoresizingMaskIntoConstraints = false
        if let newAthleteVC = segue.destination as? NewAthleteViewController {
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
    
    private func fetchAthletes() {
        //FIXME: Retrieve athletes from server
    }
    
    private func updateTableViewInsets() {
        
        let height = max(addButtonContainer.frame.height, newAthleteViewContainer.frame.height)
        tableView.contentInset = UIEdgeInsets(top: height, left: 0, bottom: 0, right: 0)
        tableView.contentOffset = CGPoint(x: 0, y: -height)
    }
    
    private func transition(to mode: AthletesListViewControllerMode, animate: Bool = true) {
        
        switch mode {
        case .consulting:
            heightConstraint?.isActive = true
        case .newAthlete:
            heightConstraint?.isActive = false
        }
        
        UIView.animate(withDuration: animate ? 0.3 : 0, animations: {
            self.view.layoutIfNeeded()
        })
    }
    
    // **************************************************************
    // MARK: - User Interaction
    // **************************************************************
    
    @IBAction func addNewAthlete(_ sender: Any) {
        transition(to: .newAthlete)
    }
}

extension AthletesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("didSelectRowAt")
    }
    
    func tableView(_ tableView: UITableView, willBeginEditingRowAt indexPath: IndexPath) {
        print("willBeginEditingRowAt")
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Suppr") { [weak self] (action, indexPath) in
            guard let athlete = self?.dataHandler.dataProvider?.item(atIndexPath: indexPath) else {
                fatalError("Error while removing user")
            }
            let realm = try! Realm()
            try? realm.safeWrite(withoutNotifying: []) {
                realm.delete(athlete)
            }
        }
        
        let showResultsAction = UITableViewRowAction(style: .default, title: "Résultats") { (action, indexPath) in
            print("showResultsAction")
        }
        
        return [showResultsAction, deleteAction]
    }
    
}



