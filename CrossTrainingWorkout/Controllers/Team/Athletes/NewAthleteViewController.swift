//
//  NewAthleteViewController.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit
import RealmSwift

protocol NewAthleteViewControllerDelegate: class {}

class NewAthleteViewController: UIViewController {
    
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var nickNameInputTextField: ValidableTextField! {
        didSet {
            nickNameInputTextField.validator = .minchars(2)
        }
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailInputTextField: ValidableTextField! {
        didSet {
            emailInputTextField.validator = .email
        }
    }
    
    weak var delegate: NewAthleteViewControllerDelegate?
    
    var dutyEndedBlock: ( (Error?) -> Void )?
    
    @IBAction func submit(_ sender: Any) {
        
        let tests: [ValidableTextField] = [nickNameInputTextField, emailInputTextField]
        
        var errors: [String] = []
        for test in tests {
            switch test.validate() {
            case .valid: continue
            case .invalid(let error):
                errors.append(error)
            }
        }
        
        let athlete = Athlete()
        athlete.id = UUID().uuidString
        athlete.firstName = nickNameInputTextField.text!
        athlete.email = emailInputTextField.text!
        
        let realm = try! Realm()
        try! realm.safeWrite(withoutNotifying: []) {
            realm.add(athlete)
            print(athlete)
        }
        
        dutyEndedBlock?(nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        dutyEndedBlock?(nil)
    }
}
