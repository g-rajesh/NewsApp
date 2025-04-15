//
//  RegisterVM.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import Foundation

struct RegisterModel {
    let fullName: String
    let email: String
    let password: String
}

class RegisterVM {
    weak var coordintor: RegistrationFlowCoordinator?
    
    init(coordintor: RegistrationFlowCoordinator) {
        self.coordintor = coordintor
    }
}

extension RegisterVM {
    func registerUser(with user: RegisterModel) {
        print(user)
    }
}
