//
//  CoreDataManager.swift
//  Events App 2
//
//  Created by Sherif Hamdy on 18/02/2025.
//

import CoreData
import UIKit

class CoreDataManager{
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
        
        let imageData = image.jpegData(compressionQuality: 1.0)
        event.setValue(imageData, forKey: "image")

        do{
            try managedObjectContext.save()
        }catch{
            debugPrint("Error while saving an event \(error.localizedDescription)")
        }
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
