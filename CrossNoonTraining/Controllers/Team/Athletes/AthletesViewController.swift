//
//  AthletesViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import UIKit

class AthletesViewController: UIViewController {
    
    // **************************************************************
    // MARK: - Athletes View Controller State
    // **************************************************************
    
    enum AthletesViewControllerState {
        case consulting
        case addingAthlete
        case loading
        case failed(Error)
    }
    
    private var state: AthletesViewControllerState?
    
    private var shownViewController: UIViewController?
    
    // **************************************************************
    // MARK: - ChildViewControllers Duty Handling
    // **************************************************************
    
    /// Handles when the capture controller has finished
    ///
    /// - Parameters:
    ///   - samples: sample images retrieved from controller
    ///   - error: error found when capturing
    private func handleConsultingDutyDone(error: Error?) {
        
        guard error == nil else {
            self.transition(to: .failed(error!) )
            return
        }
    }
    
    /// Handles when the treatment controller has finished
    ///
    /// - Parameter error: error found in treatment
    private func handleAddingAthleteDutyDone(error: Error?) {
        
        guard error == nil else {
            self.transition(to: .failed(error!) )
            return
        }
        
        self.transition(to: .consulting)
    }
    
    /// Handles when the debugging is done
    private func handleDebugginDone() {
//        self.delegate?.didFinishProcessing(document: self.document)
//        self.navigationController?.popViewController(animated: true)
    }
    
    // **************************************************************
    // MARK: - Transition
    // **************************************************************
    
    /// Transition to a new state for the current controller
    ///
    /// - Parameter newState: new state to set
    private func transition(to newState: AthletesViewControllerState) {
        shownViewController?.remove()
        
        let nextViewController = viewController(for: newState)
        add(nextViewController)
        shownViewController = nextViewController
        
        state = newState
    }
    
    /// Builds and returns a controller depending on new state
    ///
    /// - Parameter state: current state
    /// - Returns: child view controller
    private func viewController(for state: AthletesViewControllerState) -> UIViewController {
        
        switch state {
        case .consulting:
            let controller = Storyboards.team.instantiate(withType: AthletesListViewController.self)
            controller.dutyEndedBlock = handleConsultingDutyDone
            return controller
        case .addingAthlete:
            let controller = Storyboards.team.instantiate(withType: NewAthleteViewController.self)
            controller.dutyEndedBlock = handleAddingAthleteDutyDone
            return controller
        case .loading:
            return UIViewController()
        case .failed(let error):
            return UIViewController()
        }
    }
    
}

enum Storyboards: String {
    
    case team
    case wod
    case history
    
    func instantiate<T: UIViewController>(withType type: T.Type) -> T {
        let bundle = Bundle.main
        let storyboard = UIStoryboard.init(name: self.rawValue, bundle: bundle)
        
        return storyboard.instantiateViewController(withIdentifier: String(describing: T.self)) as! T
    }
}
