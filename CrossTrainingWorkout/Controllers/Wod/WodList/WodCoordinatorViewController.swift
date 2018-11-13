//
//  WodListViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 08/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

/// Class responsible for coordinating all child view controllers
class WodCoordinatorViewController: UIViewController, NibLoadable {
    
    // **************************************************************
    // MARK: - Wod List View Controller State
    // **************************************************************
    
    enum WodListViewControllerState {
        case consulting
        case newAthlete
    }
    
    // **************************************************************
    // MARK: - Variables
    // **************************************************************
    
    private var newWodViewController: WodCreationViewController!
    private var wodListTableViewController: WodListViewController!
    private var wodListFiltersViewController: WodFiltersViewController!
    
    private var heightConstraint: NSLayoutConstraint?
    
    // **************************************************************
    // MARK: - Oulets
    // **************************************************************
    
    @IBOutlet weak var newWodContainer: UIView! {
        didSet {
            self.heightConstraint = newWodContainer.heightAnchor.constraint(equalToConstant: 0)
            self.heightConstraint?.isActive = true
        }
    }
    
    // **************************************************************
    // MARK: - Life Cycle
    // **************************************************************
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewInsets()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let newWodViewController = segue.destination as? WodCreationViewController {
            
            newWodViewController.delegate = self
            newWodViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.newWodViewController = newWodViewController
        } else if let listViewController = segue.destination as? WodListViewController {
            
            listViewController.delegate = self
            
            self.wodListTableViewController = listViewController
        } else if let filterViewController = segue.destination as? WodFiltersViewController {
            self.wodListFiltersViewController = filterViewController
        }
    }
    
    // **************************************************************
    // MARK: - Private Business
    // **************************************************************
    
    /// ↔️ Transition to a specific state
    ///
    /// - Parameters:
    ///   - state: state to transition to
    ///   - animate: should animate transition (default is false)
    private func transition(to state: WodListViewControllerState, animate: Bool=true) {
        
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
        }
    }
    
    /// 🔄 Update table view insets
    private func updateTableViewInsets() {
        
        let height = newWodContainer.frame.height - wodListFiltersViewController.view.frame.height
        wodListTableViewController.updateTableViewInsets(withHeight: height)
    }
    
}

extension WodCoordinatorViewController: WodCreationViewControllerDelegate {
    
    func didSubmit(wod: Wod) {
        transition(to: .consulting)
    }
    
    func didCancel() {
        transition(to: .consulting)
    }
    
}

extension WodCoordinatorViewController: WodListViewControllerDelegate {
    
    func didAskForNewWod() {
        transition(to: .newAthlete)
    }
}
