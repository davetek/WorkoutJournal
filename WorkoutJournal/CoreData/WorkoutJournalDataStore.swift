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
    
//    as with the generic method that I created previously for fetch, the add method would take
//    the NSManagedObject class name as a parameter. It would also take a dictionary
//    of key-value pairs as the second parameter. These would represent the attributes for the NSManagedObject.

    #warning("withFields param value is dictionary with string keys, but values could be any type")
    #warning("dictionary passed in is arbitrary; it should be type-checked to only have the fields and value types for the given type")
    #warning("save context may fail; should return result of error or success")
    func addRecord<T: NSManagedObject>(ofType _: T.Type, withFields attributes: [String: Any]) {
        
        //get the entity name from the fully qualified name which is in the format "Module.EntityName"
        let fullyQualifiedEntityName = String(reflecting: T.self)
        let entityName = getSliceOf(string: fullyQualifiedEntityName, afterSubstring: ".")
        
        //make a new NSManagedObject
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("could not create data entity")
        }
        let newObject = NSManagedObject(entity: entity, insertInto: context)
        
        let entityAttributes = entity.attributesByName

        for (attributeName, attributeDescription) in entityAttributes {
            
            print("attribute name: \(attributeName)")
            print("attribute type: \(String(describing: attributeDescription.attributeValueClassName))")
            print("attribute is optional: \(attributeDescription.isOptional)")
        }
        
        //for each item in the attributes dictionary passed in the request, set an attribute
        // on the NSManagedObject
        for (attributeKey, attributeValue) in attributes {
            newObject.setValue(attributeValue, forKey: attributeKey)
        }
        
        //save the data to Core Data
        saveContext()
    }
    
    func getSliceOf(string: String, afterSubstring: Character) -> String {
        let indexAtEndOfSubstring = string.index(after: string.firstIndex(of: afterSubstring)!)
        let stringSlice = string[indexAtEndOfSubstring...]
        return String(stringSlice)
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


