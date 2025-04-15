//
//  RegistrationFlowCoordinator.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import UIKit

class RegistrationFlowCoordinator: RegistrationFlowCoordinatorProtocol {
    var navigationController: UINavigationController
    var completionHandler: (() -> Void)?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        navigationController.setNavigationBarHidden(true, animated: true)
        showOnboarding()
    }
    
    func showOnboarding() {
        let onboardingVM = OnboardingVM(coordinator: self)
        let onboardingVC = OnboardingVC(viewModel: onboardingVM)
        navigationController.pushViewController(onboardingVC, animated: true)
    }
    
    func showSignIn() {
        if let lastVC = navigationController.viewControllers.last?.presentedViewController as? RegisterVC {
            lastVC.dismiss(animated: true)
        } else {
            let loginVM = LoginVM(coordinator: self)
            let loginVC = LoginVC(viewModel: loginVM)
            loginVC.navigationItem.hidesBackButton = true
            navigationController.pushViewController(loginVC, animated: true)
        }
    }
    
    func showCreateNewUser() {
        let registerVM = RegisterVM(coordintor: self)
        let registerVC = RegisterVC(viewModel: registerVM)
        registerVC.modalPresentationStyle = .fullScreen
        registerVC.modalTransitionStyle = .flipHorizontal
        navigationController.viewControllers.last?.present(registerVC, animated: true)
    }
    
    func endFlow() {
        navigationController.setNavigationBarHidden(false, animated: true)
        completionHandler?()
    }
}
