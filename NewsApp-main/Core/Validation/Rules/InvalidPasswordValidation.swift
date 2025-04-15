//
//  InvalidPasswordValidation.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 08/04/25.
//

import Foundation

struct InvalidPasswordValidation: ValidationRule {
    let errorMessage: String?
    
    var error: String {
        return errorMessage ?? "Invalid Password"
    }
    
    func validate(with text: String) -> ValidationResult {
        let regex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[!@#$&*]).{6,}$"
        let matched = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
        
        if !matched {
            return .invalid(error)
        }
        return .valid
    }
}
