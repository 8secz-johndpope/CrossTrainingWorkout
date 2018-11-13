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
    
    private var wodCreationViewController: WodCreationViewController!
    private var wodListViewController: WodListViewController!
    private var wodFiltersViewController: WodFiltersViewController!
    
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
        
        if let creationController = segue.destination as? WodCreationViewController {
            
            wodCreationViewController = creationController
            wodCreationViewController.delegate = self
            wodCreationViewController.view.translatesAutoresizingMaskIntoConstraints = false
            
        } else if let listViewController = segue.destination as? WodListViewController {
            
            wodListViewController = listViewController
            wodListViewController.delegate = self
            
        } else if let filterViewController = segue.destination as? WodFiltersViewController {
            
            wodFiltersViewController = filterViewController
            wodFiltersViewController.delegate = self
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
        
        let height = newWodContainer.frame.height - wodFiltersViewController.view.frame.height
        wodListViewController.updateTableViewInsets(withHeight: height)
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

extension WodCoordinatorViewController: WodFiltersViewControllerDelegate {
    
    func didFilterWods(toType: WodType) {
        guard let predicate = toType.predicate else { fatalError("There is no predicate for this wod type!") }
        wodListViewController.updateTableViewPredicate(predicate)
    }
    
}
