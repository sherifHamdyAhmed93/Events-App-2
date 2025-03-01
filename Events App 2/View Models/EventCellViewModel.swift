//
//  EventCellViewModel.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 27/02/2025.
//

import Foundation
import UIKit

class EventCellViewModel{
    private(set) var event:Event
    let currentDate = Date()
    
    var eventDate:String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.YYY"
        guard let eventDate = event.date else{return ""}
        return dateFormatter.string(from: eventDate)
    }
    
    var eventName:String{
        return event.name ?? ""
    }
    
    var remainingTime:[String]{
        guard let eventDate = event.date else{return []}
        return currentDate.remainingTime(toDate: eventDate).components(separatedBy: ",")
    }
    
    init(event:Event){
        self.event = event
    }
    
    
    func loadEventImage(completion:@escaping(_ image:UIImage?)->Void){
        if let cachedImage =  CacheManager.shared.getObject(key: event.description) as? UIImage{
            completion(cachedImage)
        }else{
            DispatchQueue.global().async {
                guard let data = self.event.image , let eventImage = UIImage(data: data) else{
                    completion(nil)
                    return
                }
                CacheManager.shared.saveObject(key: self.event.description, object: eventImage)
                completion(eventImage)
            }
        }
    }
    
}
