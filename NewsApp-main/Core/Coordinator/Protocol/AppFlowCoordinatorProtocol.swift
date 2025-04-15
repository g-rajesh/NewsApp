//
//  AppFlowCoordinatorProtocol.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import UIKit

protocol AppFlowCoordinatorProtocol: Coordinator {
    var navigationController: UINavigationController { get set }
    var tabBarController: UITabBarController { get }
    
    func start()
    func logout()
}
