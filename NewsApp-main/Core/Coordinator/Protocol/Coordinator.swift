//
//  Coordinator.swift
//  NewsApp-main
//
//  Created by Rajesh Gunasekar on 31/03/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    
    func start()
}
