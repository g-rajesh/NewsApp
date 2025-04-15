//
//  RegistrationFlowCoordinatorProtocol.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import UIKit

protocol RegistrationFlowCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
    
    func showOnboarding()
    func showSignIn()
    func showCreateNewUser()
    func endFlow()
}
