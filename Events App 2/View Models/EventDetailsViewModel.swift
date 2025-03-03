//
//  EventDetailsViewModel.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 01/03/2025.
//

import Foundation
import CoreData
import UIKit

class EventDetailsViewModel{
    
    private let eventId:NSManagedObjectID
    private var event:Event?
    private weak var coordinator:EventDetailsCoordinator?

    var onUpdate = {}

    init(eventId: NSManagedObjectID,coordinator:EventDetailsCoordinator?) {
        self.eventId = eventId
        self.coordinator = coordinator
    }
    
    func viewWillDisappear(){
        coordinator?.didFinish()
    }
    
    func viewDidLoad(){
        guard let event = CoreDataManager.shared.getEvent(id: eventId) else{
            return
        }
        self.event = event
        onUpdate()
    }

    var timeRemaingViewModel:TimeRemainingViewModel?{
        guard let eventDate = event?.date else{return nil}
        return TimeRemainingViewModel(mode: .cell, eventDate: eventDate)
    }
    
    func loadEventImage(completion:@escaping(_ image:UIImage?)->Void){
        guard let eventId = event?.objectID.description else{
            completion(nil)
            return
        }
        UIImage.loadEventImage(imageName: eventId, imageData: event?.image) { image in
            completion(image)
        }
    }
    
    deinit{
        debugPrint("Deinit \(self)")
    }
    
}
