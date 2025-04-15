//
//  RegisterVC.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 30/03/25.
//

import UIKit

class RegisterVC: UIViewController {
    
    private let registerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 16.0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "logo")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 24.0, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16.0, weight: .light)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let fullNameTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14.0)
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let emailTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14.0)
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.font = .systemFont(ofSize: 14.0)
        textField.isSecureTextEntry = true
        textField.autocapitalizationType = .none
        textField.translatesAutoresizingMaskIntoConstraints = false
        
        return textField
    }()
    
    private let registerCta: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .inactive
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let hasAccountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let loginCta: UIButton = {
        let button = UIButton(type: .system)
        button.setTitleColor(.primary, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    private let hasAccountStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        stackView.alignment = .center
        stackView.distribution = .equalCentering
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let fullNameContainer: FormFieldContainer
    private let emailContainer: FormFieldContainer
    private let passwordContainer: FormFieldContainer
    private var formFieldValidators: [FormFieldValidator] = []
    
    let viewModel: RegisterVM
    init(viewModel: RegisterVM) {
        self.viewModel = viewModel
        self.fullNameContainer = FormFieldContainer(source: fullNameTextField)
        self.emailContainer = FormFieldContainer(source: emailTextField)
        self.passwordContainer = FormFieldContainer(source: passwordTextField)
        self.formFieldValidators = [
            FormFieldValidator(
                formContainer: fullNameContainer,
                rules: [
                    EmptyFieldValidation(errorMessage: "FullName cannot be empty")
                ]
            ),
            FormFieldValidator(
                formContainer: emailContainer,
                rules: [
                    EmptyFieldValidation(errorMessage: "Email cannot be empty"),
                    InvalidEmailValidation(errorMessage: nil)
                ]
            ),
            FormFieldValidator(
                formContainer: passwordContainer,
                rules: [
                    EmptyFieldValidation(errorMessage: "Password cannot be empty"),
                    InvalidPasswordValidation(errorMessage: "Password must be atleast 6 characters long including 1 upper case, 1 lowercase, 1 number and 1 special character")
                ]
            ),
        ]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        configureUI()
        addObservers()
    }

}

// MARK: RegisterVC Functions
extension RegisterVC {
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        hasAccountStackView.addArrangedSubview(hasAccountLabel)
        hasAccountStackView.addArrangedSubview(loginCta)
        
        view.addSubview(registerScrollView)
        registerScrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(fullNameContainer)
        stackView.addArrangedSubview(emailContainer)
        stackView.addArrangedSubview(passwordContainer)
        stackView.addArrangedSubview(registerCta)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(hasAccountStackView)
        
        // TODO: make use of RSwift for this
        titleLabel.text = "title".localized(using: "Register")
        descriptionLabel.text = "description".localized(using: "Register")
        fullNameTextField.placeholder = "fullname_placeholder".localized(using: "Register")
        emailTextField.placeholder = "email_placeholder".localized(using: "Register")
        passwordTextField.placeholder = "password_placeholder".localized(using: "Register")
        registerCta.setTitle("register_cta".localized(using: "Register"), for: .normal)
        hasAccountLabel.text = "has_account_text".localized(using: "Register")
        loginCta.setTitle("login_cta".localized(using: "Register"), for: .normal)
        
        // TODO: Use Extention to handle this
        fullNameTextField.setRightImage(with: "person.fill")
        emailTextField.setRightImage(with: "envelope.fill")
        passwordTextField.setRightImage(with: "eye.fill", isPassword: true)
        
        stackView.setCustomSpacing(12, after: titleLabel)
        stackView.setCustomSpacing(24, after: registerCta)
        
        [fullNameTextField, emailTextField, passwordTextField].forEach { [weak self] textField in
            guard let self else { return }
            textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        }
        
        registerCta.addTarget(self, action: #selector(registerAct), for: .touchUpInside)
        loginCta.addTarget(self, action: #selector(loginAct), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureUI() {
        // TODO: Use Snapkit
        NSLayoutConstraint.activate([
            // registerScrollView
            registerScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            registerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            registerScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // contentView
            contentView.topAnchor.constraint(equalTo: registerScrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: registerScrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: registerScrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: registerScrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: registerScrollView.widthAnchor),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: contentView.bottomAnchor),
            
            logoImageView.widthAnchor.constraint(equalToConstant: 124),
            logoImageView.heightAnchor.constraint(equalToConstant: 124),
     
            fullNameTextField.heightAnchor.constraint(equalToConstant: 48),

            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            registerCta.heightAnchor.constraint(equalToConstant: 52),
            
            containerView.heightAnchor.constraint(equalTo: hasAccountLabel.heightAnchor, multiplier: 1.1),
            
            hasAccountStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            hasAccountStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func addObservers() {
        // TODO: CHECK How to handle this in a seperate file[Signleton]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func textFieldDidChange() {
        let isEnabled = formFieldValidators.allSatisfy { $0.isValid() }
        registerCta.isEnabled = isEnabled
        if isEnabled {
            registerCta.backgroundColor = .primary
        } else {
            registerCta.backgroundColor = .inactive
        }
    }
    
    @objc private func registerAct(_ sender: UIButton) {
        guard
            let fullName = fullNameTextField.text,
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !fullName.isEmpty,
            !email.isEmpty,
            !password.isEmpty else {
            return
        }
        
        let user = RegisterModel(fullName: fullName, email: email, password: password)
        viewModel.registerUser(with: user)
    }
    
    @objc private func loginAct(_ sender: UIButton) {
        viewModel.coordintor?.showSignIn()
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            registerScrollView.contentInset.bottom = keyboardHeight + 20
            registerScrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardHeight+20, right: 0)
        }
    }
    
    @objc private func keyboardWillHide() {
        registerScrollView.contentInset = .zero
        registerScrollView.verticalScrollIndicatorInsets = .zero
    }
    
    // TODO: move from one text field to another by tapping return
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
