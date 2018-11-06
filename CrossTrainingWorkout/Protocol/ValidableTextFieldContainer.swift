//
//  ValidableTextFieldContainer.swift
//  CrossTrainingWorkout
//
//  Created by Jonathan Arnal on 06/11/2018.
//  Copyright © 2018 Nouveal. All rights reserved.
//

import Foundation

protocol ValidableTextFieldContainer {}
extension ValidableTextFieldContainer {
    
    /// 🧠 Validates all textfields and returns a list of error messages
    ///
    /// - Parameter textfields: list of validable textfields
    /// - Returns: list of error messages
    func validateInDetails(textfields: [ValidableTextField]) -> [String] {
        
        var errors: [String] = []
        for textfield in textfields {
            switch textfield.validate() {
            case .valid: continue
            case .invalid(let error), .empty(let error):
                errors.append(error)
            }
        }
        
        return errors
    }
    
    /// 🧠 Validates all textfields and returns a single string containing all messages separated by a new line
    ///
    /// - Parameter textfields: list of validable textfields
    /// - Returns: error message
    func validateGlobally(textfields: [ValidableTextField]) -> String? {
        
        let validationString = validateInDetails(textfields: textfields).joined(separator: "\n")
        return validationString.isEmpty ? nil : validationString
    }
    
}
