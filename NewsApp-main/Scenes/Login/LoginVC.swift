//
//  LoginVC.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 30/03/25.
//

import UIKit

class LoginVC: UIViewController {
    
    private let loginScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let svContentView: UIView = {
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

    private let loginCta: UIButton = {
        let button = UIButton(type: .system)
        button.backgroundColor = .inactive
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.isEnabled = false
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let newUserLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14.0)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let registerCta: UIButton = {
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
    
    private let newUserStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4.0
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        return stackView
    }()
    
    private let emailConatiner: FormFieldContainer
    private let passwordContainer: FormFieldContainer
    private var formFieldValidators: [FormFieldValidator] = []
    
    let viewModel: LoginVM
    init(viewModel: LoginVM) {
        self.viewModel = viewModel
        
        self.emailConatiner = FormFieldContainer(source: emailTextField)
        self.passwordContainer = FormFieldContainer(source: passwordTextField)
        formFieldValidators = [
            FormFieldValidator(
                formContainer: emailConatiner,
                rules: [
                    EmptyFieldValidation(errorMessage: "Email cannot be empty"),
                    InvalidEmailValidation(errorMessage: nil)
                ]
            ),
            FormFieldValidator(
                formContainer: passwordContainer,
                rules: [
                    EmptyFieldValidation(errorMessage: "Password cannot be empty")
                ]
            )
        ]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        // TODO: what is the ideal way to handle this scenarios instead of throwing error
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
extension LoginVC {
    private func setupUI() {
        view.backgroundColor = .systemGray6
        
        newUserStackView.addArrangedSubview(newUserLabel)
        newUserStackView.addArrangedSubview(registerCta)
        
        view.addSubview(loginScrollView)
        loginScrollView.addSubview(svContentView)
        svContentView.addSubview(stackView)
        stackView.addArrangedSubview(logoImageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(emailConatiner)
        stackView.addArrangedSubview(passwordContainer)
        stackView.addArrangedSubview(loginCta)
        stackView.addArrangedSubview(containerView)
        containerView.addSubview(newUserStackView)
        
        // TODO: make use of RSwift for this
        titleLabel.text = "title".localized(using: "Login")
        descriptionLabel.text = "description".localized(using: "Login")
        emailTextField.placeholder = "email_placeholder".localized(using: "Login")
        passwordTextField.placeholder = "password_placeholder".localized(using: "Login")
        loginCta.setTitle("login_cta".localized(using: "Login"), for: .normal)
        newUserLabel.text = "new_user_text".localized(using: "Login")
        registerCta.setTitle("register_cta".localized(using: "Login"), for: .normal)
        
        emailTextField.setRightImage(with: "envelope.fill")
        passwordTextField.setRightImage(with: "eye.fill", isPassword: true)
        
        stackView.setCustomSpacing(12.0, after: titleLabel)
        stackView.setCustomSpacing(24.0, after: loginCta)
        
        [emailTextField, passwordTextField].forEach { [weak self] textField in
            guard let self else { return }
            textField.addTarget(self, action: #selector(didTextFieldChange), for: .editingChanged)
        }
        loginCta.addTarget(self, action: #selector(loginAct), for: .touchUpInside)
        registerCta.addTarget(self, action: #selector(registerAct), for: .touchUpInside)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(keyboardDismiss))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureUI() {
        // TODO: Use Snapkit
        NSLayoutConstraint.activate([
            // loginScrollView
            loginScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            loginScrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            loginScrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            loginScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            // svContentView
            svContentView.topAnchor.constraint(equalTo: loginScrollView.topAnchor),
            svContentView.leadingAnchor.constraint(equalTo: loginScrollView.leadingAnchor),
            svContentView.trailingAnchor.constraint(equalTo: loginScrollView.trailingAnchor),
            svContentView.bottomAnchor.constraint(equalTo: loginScrollView.bottomAnchor),
            svContentView.widthAnchor.constraint(equalTo: loginScrollView.widthAnchor),
            
            // stackView
            stackView.topAnchor.constraint(equalTo: svContentView.topAnchor, constant: 100),
            stackView.leadingAnchor.constraint(equalTo: svContentView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: svContentView.trailingAnchor, constant: -20),
            stackView.bottomAnchor.constraint(lessThanOrEqualTo: svContentView.bottomAnchor),
            
            // logoImageView
            logoImageView.widthAnchor.constraint(equalToConstant: 124),
            logoImageView.heightAnchor.constraint(equalToConstant: 124),
            
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
            
            loginCta.heightAnchor.constraint(equalToConstant: 52),
            
            // newUserStackView
            containerView.heightAnchor.constraint(equalTo: newUserLabel.heightAnchor, multiplier: 1.1),
            newUserStackView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            newUserStackView.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func addObservers() {
        // TODO: CHECK How to handle this in a seperate file[Signleton]
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func didTextFieldChange(_ textField: UITextField) {
        let isEnabled = formFieldValidators.allSatisfy { $0.isValid() }
        loginCta.isEnabled = isEnabled
        if isEnabled {
            loginCta.backgroundColor = .primary
        } else {
            loginCta.backgroundColor = .inactive
        }
    }
    
    @objc private func loginAct(_ sender: UIButton) {
        guard
            let email = emailTextField.text,
            let password = passwordTextField.text,
            !email.isEmpty,
            !password.isEmpty else {
                return
            }
        
        let user = LoginModel(email: email, password: password)
        viewModel.loginUser(with: user)
    }

    @objc private func registerAct(_ sender: UIButton) {
        viewModel.coordinator?.showCreateNewUser()
    }
    
    @objc private func keyboardDismiss() {
        // TODO: how to add this in separate file
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        if let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect {
            let keyboardHeight = keyboardFrame.height
            loginScrollView.contentInset.bottom = keyboardHeight + 20
            loginScrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
        }
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        loginScrollView.contentInset = .zero
        loginScrollView.verticalScrollIndicatorInsets = .zero
    }
}
