//
//  CoreDataManager.swift
//  CBLinho
//
//  Created by Ada 2018 on 28/09/18.
//  Copyright © 2018 Ada 2018. All rights reserved.
//

import CoreData

class CoreDataManager {
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LiciStation")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    static func fetch<T>(_ request: NSFetchRequest<T>) -> [T]{
        do{
            let result = try persistentContainer.viewContext.fetch(request)
            return result
        } catch{
            print(error)
            return [T]()
        }
    }
    
    static func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension Cebelinho {
    convenience init(){
        self.init(context : CoreDataManager.persistentContainer.viewContext)
    }
}
