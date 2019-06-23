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
    
    //Liam: from POV of function
    //solution could be to call this function 
    
    func update<T: NSManagedObject, U>(object: inout T, withFields fields: [WritableKeyPath<T, U>: U]) {
        
        for (fieldKey, fieldValue) in fields {
            object[keyPath: fieldKey] = fieldValue
        }
    }
    
    func updateForAnyPropertyTypes<T: NSManagedObject>(object: T, withFields fields: [String: Any]) {
        
        //for each item in the attributes dictionary passed in the request, set an attribute
        // on the NSManagedObject
        for (fieldKey, fieldValue) in fields {
            object.setValue(fieldValue, forKey: fieldKey)
            
        }
        
        // save the data to Core Data
        saveContext()
    }
    
//    define a generic add method that takes a Core Data entity name and a dictionary
//    of key-value pairs, representing attributes and relationships, as parameters.
    #warning("dictionary passed in is arbitrary; it should be validated against the attributes & relationships of the given type")
    #warning("save context may fail; should return result of error or success")
    func addRecord<T: NSManagedObject>(ofType _: T.Type, withAttributes attributes: [String: Any]) {
        
        //get the entity name from the fully qualified name which is in the format "Module.EntityName"
        let fullyQualifiedEntityName = String(reflecting: T.self)
        let entityName = getSliceOf(string: fullyQualifiedEntityName, afterSubstring: ".")
        
        //make a new NSManagedObject
        guard let entity = NSEntityDescription.entity(forEntityName: entityName, in: context) else {
            fatalError("could not create data entity")
        }
        let entityAttributes = entity.attributesByName
        let entityRelationships = entity.relationshipsByName

        let newObject = NSManagedObject(entity: entity, insertInto: context)


        for (attributeName, attributeDescription) in entityAttributes {
            print("attribute name: \(attributeName)")
            if let attributeType = attributeDescription.attributeValueClassName {
                print("attribute type: \(attributeType)")
            }
            print("attribute is optional: \(attributeDescription.isOptional)")
            print("")
        }
        print("")
        
        for (relationshipName, relationshipDescription) in entityRelationships {
            print("relation name: \(relationshipName)")
            print("relationship is optional: \(relationshipDescription.isOptional)")
            print("relationship is ToMany: \(relationshipDescription.isToMany)")

            if let destinationEntity = relationshipDescription.destinationEntity {
                if let destinationEntityName = destinationEntity.name {
                    print("destination entity: \(destinationEntityName)")
                }
            }
            print("")
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
    

    
    
    func delete(dataObject: NSManagedObject) {
        
        context.delete(dataObject)
        do {
            try context.save()
        } catch let error {
            if error._code == 1600 {
                print("Cannot delete type - it is being used by an exercise!")
                
                //Removes everything from the undo stack, discards all insertions and deletions,
                //and restores updated objects to their last committed values.
                context.rollback()
            } else {
                print("Error when attempting to delete record: \(error)")
            }
        }
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
    



    
    
    
    //pre-populate Core Data with exercise types
    func addBasicExerciseTypesToCoreData() {
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Aerobic"])
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Calisthenics"])
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Core"])
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Stretching"])
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Weight Training"])
        addRecord(ofType: ExerciseType.self, withAttributes: ["name": "Yoga"])
    }
    
}


