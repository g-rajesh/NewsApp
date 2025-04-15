//
//  ValidationProtocol.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 06/04/25.
//

protocol ValidationRule {
    func validate(with text: String) -> ValidationResult
}
