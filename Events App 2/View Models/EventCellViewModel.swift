//
//  EventCellViewModel.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import Foundation
import UIKit
import CoreData

class EventCellViewModel{
    private(set) var event:Event
    let currentDate = Date()
    var onSelect:(NSManagedObjectID)->() = {_ in}
    
    var eventDate:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYY"
        guard let eventDate = event.date else{return ""}
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName:String{
        return event.name ?? ""
    }
    
    var timeRemaingViewModel:TimeRemainingViewModel?{
        guard let eventDate = event.date else{return nil}
        return TimeRemainingViewModel(mode: .cell, eventDate: eventDate)
    }
    
    init(event:Event){
        self.event = event
    }
    
    func loadEventImage(completion:@escaping(_ image:UIImage?)->Void){
        UIImage.loadEventImage(imageName: event.objectID.description, imageData: event.image) { image in
            completion(image)
        }
    }
    
    func selectEvent(){
        onSelect(event.objectID)
    }
    
}
