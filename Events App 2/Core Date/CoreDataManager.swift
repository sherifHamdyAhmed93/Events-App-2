//
//  CoreDataManager.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import CoreData
import UIKit

class CoreDataManager{
    
    static let shared = CoreDataManager()
    
    private init(){}
    
    
    private let dataBaseName = "EventsApp"
    lazy var persistentContainer:NSPersistentContainer = {
       let container = NSPersistentContainer(name: dataBaseName)
        container.loadPersistentStores { _, error in
            if let error{
                debugPrint("Error while init container \(error.localizedDescription)")
            }
        }
        return container
    }()
    
    private var managedObjectContext:NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    func saveEvent(name:String,date:Date,image:UIImage){
        let event = Event(context:managedObjectContext)
        event.setValue(name, forKey: "name")
        event.setValue(date, forKey: "date")
        let newImage = image.sameAspectRatio(newHeight: 250)
        let imageData = newImage.jpegData(compressionQuality: 0.5)
        event.setValue(imageData, forKey: "image")

        do{
            try managedObjectContext.save()
        }catch{
            debugPrint("Error while saving an event \(error.localizedDescription)")
        }
    }
    
    func getEvent(id:NSManagedObjectID)->Event?{
        do{
            return try managedObjectContext.existingObject(with: id)  as? Event
        }catch{
            debugPrint("Error when try to retervie object")
        }
        return nil
    }
    
    func fetchEvents()->[Event]{
        let fetchRequest = NSFetchRequest<Event>(entityName: "Event")
        do{
            let events = try managedObjectContext.fetch(fetchRequest)
            return events
        }catch{
            debugPrint("Error while fetching events \(error.localizedDescription)")
            return []
        }
    }
    
}
