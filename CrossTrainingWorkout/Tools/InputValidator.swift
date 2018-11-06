//
//  InputValidator.swift
//  CrossNoonTraining
//
//  Created by Jonathan Arnal on 14/05/2018.
//  Copyright © 2018 Jonathan Arnal. All rights reserved.
//

import Foundation

enum ValidatedData {
    
    case valid(String)
    case invalid(String)
    case empty(String)
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
    case password(Int)
    case passwordCorrespondance
    case firstname
    
    //****************************************************
    // MARK: - Public variables
    //****************************************************
    
    /// Error message
    public var title: String? {
        switch self {
        case .postalCode:
            return Localizations.InputValidation.Address.PostalCode.Title
        case .phoneNumber:
            return Localizations.InputValidation.PhoneNumber.Title
        case .email:
            return Localizations.InputValidation.Email.Title
        case .password:
            return Localizations.InputValidation.Password.Title
        case .firstname:
            return Localizations.InputValidation.Firstname.Title
        default:
            return nil
        }
    }
    
    public var invalidMessage: String {
        return Localizations.InputValidation.Status.Invalid(title ?? Localizations.InputValidation.Default.Title)
    }
    
    public var emptyMessage: String {
        return Localizations.InputValidation.Status.Empty(title ?? Localizations.InputValidation.Default.Title)
    }
    
    //****************************************************
    // MARK: - Public methods
    //****************************************************
    
    /// Validates a value for the current type of validator
    ///
    /// - Parameter value: the data to validate
    /// - Returns: .valid or .invalid(errorMessages)
    public func validate(value: String?) -> ValidatedData {
        
        if let unwrappedValue = value, unwrappedValue.isEmpty == false {
            if validator(unwrappedValue) {
                return .valid(unwrappedValue)
            } else {
                return .invalid(invalidMessage)
            }
        }
        return .empty(emptyMessage)
    }
    
    //****************************************************
    // MARK: - Public methods
    //****************************************************
    
    /// Validator
    public var validator: (String) -> Bool {
        switch self {
        case .minchars(let charNumber), .city(let charNumber), .password(let charNumber):
            return { $0.count >= charNumber }
        case .firstname:
            return { $0.count >= 3 }
        case .postalCode(let charNumber):
            return { $0.capturedGroups(withRegex: "^([0-9]{\(charNumber)})$").count == 1 }
        case .phoneNumber:
            return { $0.capturedGroups(withRegex: "^([0-9]{10,15})$").count == 1 }
        case .email:
            return { $0.capturedGroups(withRegex: "^([A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,})$").count == 1 }
        default:
            print("Validator not implemented for \(self)")
            return { _ in false }
        }
    }
    
}
