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
    
    let context: NSManagedObjectContext = {
        let container = NSPersistentContainer(name: "WorkoutJournal")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error setting up Core Data: \(error)")
            }
        }
        return container.viewContext
    }()
    
    
    //define a generic fetch function that will take any NSManagedObject type
    func fetchRecordsFrom<T: NSManagedObject>(ofType _: T.Type) -> [T] {
        
        //Set up a request for all NSManagedObject objects
        let request: NSFetchRequest = T.self.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        //create a sort descriptor to sort ascending alphabetically
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        //assign the new sort descriptor to the request
        request.sortDescriptors = [sort]
        
        //fetch records from Core Data & assign to variable if successful
        do {
            let result = try context.fetch(request)
            return result as! [T]
            
        } catch {
            print("fetch from Core Data failed")
            return []
        }
    }
    
    func addExerciseTypeToCoreData(exerciseTypeName: String?) {
        
        // add a record to Core Data data store
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseType", in: context)
        let newExerciseType = NSManagedObject(entity: entity!, insertInto: context)
        
        newExerciseType.setValue(exerciseTypeName, forKey: "name")
        
        // save the data to Core Data
        saveContext()
    }

    
    //save the Core Data context
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
                print("ran saveContext method")
            } catch {
                print("An error occurred while saving: \(error)")
            }
        }
    }
    


    //delete any object subclassed from NSManagedObject
    func delete(object: NSManagedObject) {
        
        context.delete(object)
        saveContext()
    }
    
    
    
    //pre-populate Core Data with exercise types
    func addBasicExerciseTypesToCoreData() {
        addExerciseTypeToCoreData(exerciseTypeName: "Aerobic")
        addExerciseTypeToCoreData(exerciseTypeName: "Calisthenics")
        addExerciseTypeToCoreData(exerciseTypeName: "Core")
        addExerciseTypeToCoreData(exerciseTypeName: "Stretching")
        addExerciseTypeToCoreData(exerciseTypeName: "Weight Training")
        addExerciseTypeToCoreData(exerciseTypeName: "Yoga")
    }
    
}


