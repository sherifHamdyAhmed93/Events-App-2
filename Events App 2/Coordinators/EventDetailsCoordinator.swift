//
//  EventDetailsCoordinator.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import Foundation
import UIKit
import CoreData

class EventDetailsCoordinator:Coordinator{
    private(set) var childCoordinators: [Coordinator] = []
    
    private var navigationController:UINavigationController
    private let eventId:NSManagedObjectID
    var parentCoordinator:EventListCoordinator?

    
    init(navigationController: UINavigationController,eventId:NSManagedObjectID) {
        self.navigationController = navigationController
        self.eventId = eventId
    }
    
    func start() {
        let eventDetailsViewModel = EventDetailsViewModel(eventId: eventId, coordinator: self)
        let eventDetailsVC = EventDetailsVC(viewModel: eventDetailsViewModel)
        self.navigationController.pushViewController(eventDetailsVC, animated: true)
    }
    
    func didFinish(){
        parentCoordinator?.childDidFinish(childCoordinator: self)
    }
    
    deinit{
        debugPrint("Deinit \(self)")
    }
    
    
    
}
