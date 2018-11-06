//
//  NewAthleteViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit

struct NewAthleteLogicController: AppDependent, ValidableTextFieldContainer {
    
    /// 🏭 Builds an user
    ///
    /// - Parameters:
    ///   - firstname: firstname of the user
    ///   - email: email of the user
    /// - Returns: Athlete model
    public func buildUser(withFirstName firstname: String, andEmail email: String) -> Athlete {
        
        let athlete = Athlete()
        athlete.id = UUID().uuidString
        athlete.firstName = firstname
        athlete.email = email
        
        return athlete
    }
    
}

class NewAthleteViewController: UIViewController, CommonStateTransitionable {
    
    // **************************************************************
    // MARK: - Outlets
    // **************************************************************
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nickNameInputTextField: ValidableTextField! {
        didSet {
            nickNameInputTextField.validator = .firstname
        }
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailInputTextField: ValidableTextField! {
        didSet {
            emailInputTextField.validator = .email
        }
    }
    
    private var logicController: NewAthleteLogicController!
    
    var dutyEndedBlock: ( (Error?) -> Void )?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logicController = NewAthleteLogicController()
    }
    
    // **************************************************************
    // MARK: - User Interaction
    // **************************************************************
    
    /// 👆 Handles when user submit the data
    ///
    /// - Parameter sender: _
    @IBAction func submit(_ sender: Any) {
        
        view.endEditing(true)
        
        let textfields: [ValidableTextField] = [nickNameInputTextField, emailInputTextField]
        
        if let errorString = logicController.validateGlobally(textfields: textfields) {
            transition(toCommonState: .failure(errorString))
            return
        }
        
        let athlete = logicController.buildUser(withFirstName: nickNameInputTextField.text!, andEmail: emailInputTextField.text!)
        
        do {
            try logicController.database.save(athlete, updateIfExisting: false)
        } catch {
            transition(toCommonState: .failure(error.localizedDescription))
        }
        
        dutyEndedBlock?(nil)
    }
    
    /// 👆 Handles when user cancels input
    ///
    /// - Parameter sender: _
    @IBAction func cancel(_ sender: Any) {
        view.endEditing(true)
        dutyEndedBlock?(nil)
    }
}
