//
//  CoreDataDataStore.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/19/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDataStore {
    
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
    
    func saveContext() {
        if persistentContainer.viewContext.hasChanges {
            do {
                try persistentContainer.viewContext.save()
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
}
