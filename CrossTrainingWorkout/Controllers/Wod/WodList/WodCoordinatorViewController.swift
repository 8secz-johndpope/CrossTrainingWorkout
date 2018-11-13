//
//  WodListViewController.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 08/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class WodCoordinatorViewController: UIViewController, NibLoadable {
    
    // **************************************************************
    // MARK: - Athletes List View Controller State
    // **************************************************************
    
    enum WodListViewControllerState {
        case consulting
        case newAthlete
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    private var newWodViewController: WodCreationViewController!
    private var wodListTableViewController: WodListViewController!
    private var wodListFiltersViewController: WodFiltersViewController!
    
    var heightConstraint: NSLayoutConstraint?
    
    @IBOutlet weak var newWodContainer: UIView! {
        didSet {
            self.heightConstraint = newWodContainer.heightAnchor.constraint(equalToConstant: 0)
            self.heightConstraint?.isActive = true
        }
    }
    
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
        
        let t = newWodContainer.frame.height - wodListFiltersViewController.view.frame.height
        wodListTableViewController.updateTableViewInsets(withHeight: t)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateTableViewInsets()
    }
    
}

extension WodCoordinatorViewController: WodCreationViewControllerDelegate {
    
    func didSubmit(wod: Wod) {
        //?
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
