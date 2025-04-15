//
//  AppFlowCoordinator.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import UIKit

class AppFlowCoordinator: AppFlowCoordinatorProtocol {
    var navigationController: UINavigationController
    var tabBarController: UITabBarController
    
    var isAuth: Bool {
        get {
            return false
        }
    }
    
    var childCoordinators = [Coordinator]()
    
    init(navigationController: UINavigationController, tabBarController: UITabBarController) {
        self.navigationController = navigationController
        self.tabBarController = tabBarController
    }
    
    func start() {
        if isAuth {
            // route to home coordinator
        } else {
            showRegistrationFlow()
        }
    }
    
    private func showRegistrationFlow() {
        let registrationFlowCoordinator = RegistrationFlowCoordinator(navigationController: navigationController)
        registrationFlowCoordinator.start()
        childCoordinators.append(registrationFlowCoordinator)
        registrationFlowCoordinator.completionHandler = { [weak self] in
            self?.removeCoordinator(registrationFlowCoordinator)
        }
    }
    
    private func removeCoordinator(_ coordinator: Coordinator) {
        guard let index = childCoordinators.firstIndex(where: { $0 === coordinator }) else { return }
        childCoordinators.remove(at: index)
    }
    
    func logout() {
        
    }
}
