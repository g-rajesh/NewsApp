//
//  LoginVM.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import Foundation
import Combine

struct LoginModel {
    let email: String
    let password: String
}

class LoginVM: ObservableObject {
    weak var coordinator: RegistrationFlowCoordinator?
    
    init(coordinator: RegistrationFlowCoordinator? = nil) {
        self.coordinator = coordinator
        
        binding()
    }
}

// MARK: - LoginVM Functions
extension LoginVM {
    private func binding() {
        
    }
    
    func loginUser(with user: LoginModel) {
        print(user)
    }
}
