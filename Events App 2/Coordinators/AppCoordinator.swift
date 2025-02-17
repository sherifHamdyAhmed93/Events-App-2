//
//  AppCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 17/02/2025.
//

import UIKit

protocol Coordinator{
    var childCoordinators:[Coordinator] {get}
    func start()
}

class AppCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    private(set) var navigationController:UINavigationController?
    private let window:UIWindow

    init(window:UIWindow){
        self.window = window
    }
    
    func start() {
        navigationController = UINavigationController()
        
        let eventListCoordinator = EventListCoordinator(navigationController: navigationController)
        eventListCoordinator.start()
        
        self.childCoordinators.append(eventListCoordinator)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
