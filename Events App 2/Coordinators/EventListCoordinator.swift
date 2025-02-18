//
//  EventListCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 17/02/2025.
//

import UIKit

class EventListCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    private let navigationController:UINavigationController
    
    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
       let vc  = EventListVC()
        navigationController.setViewControllers([vc], animated: true)
    }
}
