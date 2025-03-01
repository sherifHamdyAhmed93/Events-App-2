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
    var OnSaveEvent = {}

    init(navigationController:UINavigationController){
        self.navigationController = navigationController
    }
    
    func start() {
        let eventListVM = EventListViewModel(coordinator: self)
        OnSaveEvent = eventListVM.reloadData
        let vc  = EventListVC(vm: eventListVM)
        navigationController.setViewControllers([vc], animated: true)
    }
    
    func startAddEvent(){
        let addEventCoordinator = AddEventCoordinator(navigationController: navigationController)
        addEventCoordinator.parentCoordinator = self
        childCoordinators.append(addEventCoordinator)
        
        addEventCoordinator.start()
    }
    
    func childDidFinish(childCoordinator:Coordinator){
        if let index = childCoordinators.firstIndex(where: { coordinator in
            return coordinator === childCoordinator
        }){
            self.childCoordinators.remove(at: index)
        }
    }
    
    
}
