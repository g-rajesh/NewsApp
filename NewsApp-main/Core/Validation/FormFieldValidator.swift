//
//  FormFieldValidator.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 06/04/25.
//

import UIKit

class FormFieldValidator {
    let formContainer: FormFieldContainer
    let rules: [ValidationRule]
    
    init(formContainer: FormFieldContainer, rules: [ValidationRule]) {
        self.formContainer = formContainer
        self.rules = rules
        
        setup()
    }
    
}

// MARK: FormFieldValidator Functions
extension FormFieldValidator {
    private func setup() {
        formContainer.source.addTarget(self, action: #selector(clearError), for: .editingChanged)
        formContainer.source.addTarget(self, action: #selector(validate), for: .editingDidEnd)
    }
    
    @objc private func clearError() {
        formContainer.hideError()
    }
    
    @objc private func validate() {
        let source = formContainer.source
        for rule in self.rules {
            let result = rule.validate(with: source.text ?? "")
            if case .invalid(let errorMessage) = result {
                formContainer.showError(with: errorMessage)
                return
            }
        }
        formContainer.hideError()
    }
    
    func isValid() -> Bool {
        let source = formContainer.source
        for rule in self.rules {
            let result = rule.validate(with: source.text ?? "")
            if case .invalid(_) = result {
                return false
            }
        }
        return true
    }
}
