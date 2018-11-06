//
//  ValidableTextField.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 07/08/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import UIKit

class ValidableTextField: UITextField {
    
    var validator: InputValidator?
    
    var validationStatus: ValidatedData = .invalid(Localizations.InputValidation.NotValidated)
    
    func validate() -> ValidatedData {
        
        guard let validator = self.validator else { fatalError("Trying to validate without any validator set") }
        
        let validatedData = validator.validate(value: self.text)
        validationStatus = validatedData
        return validatedData
    }
    
}
