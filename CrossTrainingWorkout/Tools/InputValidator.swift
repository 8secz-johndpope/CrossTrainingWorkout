//
//  InputValidator.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 14/05/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation

enum ValidatedData {
    
    case valid
    case invalid(String)
}

enum InputValidator {
    
    //****************************************************
    // MARK: - Cases
    //****************************************************
    
    case email
    case phoneNumber
    case addressStreet
    case city(Int)
    case minchars(Int)
    case digitsOnly
    case postalCode(Int)
    case passwordResetCode
    case password(Int)
    
    //****************************************************
    // MARK: - Public variables
    //****************************************************
    
    /// Error message
    public var errorMessage: String {
        switch self {
        case .postalCode:
            return "Localizations.InputValidation.Address.PostalCode.Invalid"
        case .phoneNumber:
            return "Localizations.InputValidation.PhoneNumber.Invalid"
        case .email:
            return "Localizations.InputValidation.Email.Invalid"
        case .city:
            return "Localizations.InputValidation.Address.City.Invalid"
        case .passwordResetCode:
            return "Localizations.InputValidation.PasswordCode.Invalid"
        case .password:
            return "Localizations.InputValidation.Password.Invalid"
        case .minchars(let minSize):
            return "Sould be at least \(minSize)"
        default:
            return ""
        }
    }
    
    //****************************************************
    // MARK: - Public methods
    //****************************************************
    
    /// Validates a value for the current type of validator
    ///
    /// - Parameter value: the data to validate
    /// - Returns: .valid or .invalid(errorMessages)
    public func validate(value: String?) -> ValidatedData {
        
        if let unwrappedValue = value, value != "" {
            if validator(unwrappedValue) {
                return .valid
            } else {
                return .invalid(self.errorMessage)
            }
        }
        return .invalid(self.errorMessage)
    }
    
    //****************************************************
    // MARK: - Public methods
    //****************************************************
    
    /// Validator
    public var validator: (String) -> Bool {
        switch self {
        case .minchars(let charNumber), .city(let charNumber), .password(let charNumber):
            return { $0.count >= charNumber }
        case .postalCode(let charNumber):
            return { $0.capturedGroups(withRegex: "^([0-9]{\(charNumber)})$").count == 1 }
        case .phoneNumber:
            return { $0.capturedGroups(withRegex: "^([0-9]{10,15})$").count == 1 }
        case .email:
            return { $0.capturedGroups(withRegex: "^([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})$").count == 1 }
        case .passwordResetCode:
            return { $0.count >= 6 }
        default:
            print("Validator not implemented for \(self)")
            return { _ in false }
        }
    }
    
}
