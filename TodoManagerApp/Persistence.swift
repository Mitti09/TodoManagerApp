//
//  Persistence.swift
//  TodoManagerApp
//
//  Created by DevApp on 2022/02/22.
//

import CoreData
import Foundation

class PersistenceController {
   static let shared = PersistenceController()
    
    private let persistentContainer: NSPersistentContainer = {
        let storeURL = FileManager.appGroupContainerURL!.appendingPathComponent("Item")
        
        let container = NSPersistentContainer(name: "TodoManagerApp")
        container.persistentStoreDescriptions = [NSPersistentStoreDescription(url: storeURL)]
                container.loadPersistentStores(completionHandler: { storeDescription, error in
                    if let error = error as NSError? {
                        print(error.localizedDescription)
                    }
                })
                return container
            }()
    }

extension PersistenceController {
    var managedObjectContext: NSManagedObjectContext {
        persistentContainer.viewContext
    }
    
    var workingContext: NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        context.parent = managedObjectContext
        
        return context
    }
}

extension FileManager {
    static let appGroupContainerURL = FileManager.default
        .containerURL(forSecurityApplicationGroupIdentifier: "group.com.gmail.Application01.Develop.TodoManagerApp.Widget")
}
