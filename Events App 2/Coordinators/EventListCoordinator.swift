//
//  EventListCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 17/02/2025.
//

import UIKit

class EventListCoordinator:Coordinator{
    var childCoordinators: [Coordinator] = []
    private(set) var navigationController:UINavigationController?
    
    init(navigationController:UINavigationController?){
        self.navigationController = navigationController
    }
    
    func start() {
       let vc  = ViewController()
        vc.view.backgroundColor = .blue
        navigationController?.setViewControllers([vc], animated: true)
    }
}
