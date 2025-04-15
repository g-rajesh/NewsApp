//
//  EmptyFieldValidation.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 06/04/25.
//

struct EmptyFieldValidation: ValidationRule {
    let errorMessage: String?
    
    var error: String {
        errorMessage ?? "This input cannot be empty"
    }
    
    func validate(with text: String) -> ValidationResult {
        if text.isEmpty {
            return .invalid(error)
        }
        return .valid
    }
}
