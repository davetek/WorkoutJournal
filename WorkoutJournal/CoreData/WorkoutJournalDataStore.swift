//
//  WorkoutJournalDataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/19/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation
import CoreData

class WorkoutJournalDataStore {
    
    
    
    //create NSPersistentContainer which will read & write data from 'disk'
    let persistentContainer: NSPersistentContainer = {
        //instantiate persistent container using name of Core Data data model
        let container = NSPersistentContainer(name: "WorkoutJournal")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data: \(error)")
            }
        }
        return container
    }()
    
    //save the Core Data context
    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
                print("ran saveContext method")
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    

    
    //get records from Core Data from any object subclassed from NSManagedObject
    // and containing a 'name' attribute; sort the records alphabetically by 'name'
    // (could make a protocol that specifies a name property, and specify that
    // T adopts that protocol
    func read<T: NSManagedObject>(_ object: T) -> [T]? {
        let context = persistentContainer.viewContext
        
        //get name of T type to pass to fetch by using T at runtime
        let request = NSFetchRequest<T>(entityName: String(describing: T.self))
        request.returnsObjectsAsFaults = false
        
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        //temp; this hides the fact that Core Data fetch failed
        var result: [T] = []
        
        do {
            result = try context.fetch(request)
            return result
        } catch let error as NSError {
            //need to handle error
            //could use 'return' type
            print("fetch from Core Data failed due to \(error)")
            return nil
        }
    }
    


    //delete any object subclassed from NSManagedObject
    func delete(object: NSManagedObject) {
        
        let context = persistentContainer.viewContext
        context.delete(object)
        saveContext()
    }
    
}


