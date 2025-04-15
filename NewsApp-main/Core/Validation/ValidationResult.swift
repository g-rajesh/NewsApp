//
//  ValidationResult.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 06/04/25.
//

enum ValidationResult {
    case valid
    case invalid(String)
    
    var isValid: Bool {
        if case .valid = self {
            return true
        }
        return false
    }
}
