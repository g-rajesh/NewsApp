//
//  FormContainer.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 06/04/25.
//

import UIKit

final class FormFieldContainer: UIView {
    let source: UITextField
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .primary
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    init(source: UITextField) {
        self.source = source
        super.init(frame: .zero)

        setupUI()
    }
    
    // TODO: How to handle this efficiently
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: FormContainer Functions
extension FormFieldContainer {
    private func setupUI() {
        containerStack.addArrangedSubview(source)
        containerStack.addArrangedSubview(errorLabel)
        addSubview(containerStack)
                
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        hideError()
    }
    
    func showError(with message: String) {
        errorLabel.text = message
        errorLabel.isHidden = false
    }
    
    func hideError() {
        errorLabel.text = ""
        errorLabel.isHidden = true
    }
}
