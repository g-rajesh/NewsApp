//
//  InvalidEmailValidation.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 08/04/25.
//

import Foundation

struct InvalidEmailValidation: ValidationRule {
    let errorMessage: String?
    
    var error: String {
        return errorMessage ?? "Invalid Email format"
    }
    
    func validate(with text: String) -> ValidationResult {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let matched = NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: text)
        
        if !matched {
            return .invalid(error)
        }
        return .valid
    }
}
