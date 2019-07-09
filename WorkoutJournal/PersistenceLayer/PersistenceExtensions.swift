//
//  PersistenceExtensions.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/6/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import Foundation
import CoreData


extension NSManagedObjectContext: WritableDataStore {
    func addModelItem<T>(ofType modelType: T.Type, withProperties properties: [String : Any]) where T : Model {
        <#code#>
    }
    
    func update<T>(modelObject: T, withProperties properties: [String : Any]) where T : Model {
        <#code#>
    }
    
    func delete<T>(dataObject: T) where T : Model {
        <#code#>
    }
    
    func saveChanges() {
        <#code#>
    }
    
    
}

extension NSFetchRequest: Query {
    
    @objc var fromModelName: String? {
        
        get {
            return self.entityName
        }
    }
    
   @objc var orderBy: [NSSortDescriptor]? {
        get {
            return self.sortDescriptors
        }
        set {
            self.sortDescriptors = newValue
        }
    }
    
    @objc var filterBy: NSPredicate? {
        get {
            return self.predicate
        }
        set {
            self.predicate = newValue
        }
    }
}


extension Exercise: Model, ExerciseModel {
    
    static func generateQuery() -> Query {
        let request: NSFetchRequest = self.fetchRequest()
        return request
    }
    
    static func generateSortDescriptor(forKey key: String, ascending: Bool) -> NSSortDescriptor {
        let sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
        return sortDescriptor
    }
    
    var exerciseType: ExerciseTypeModel? {
        get {
            return self.exerciseType
        }
        set {
            self.exerciseType = newValue
        }
    }
    
    static func addWith(name: String?, exerciseType: ExerciseTypeModel?, url: String?, dataStore: DataStore?) {
        
        var newModelInstance: NSManagedObject
        
        guard let context = self.managedObjectContext else {
            preconditionFailure("could not add exercise; context is not available")
        }
        newModelInstance = NSManagedObject(entity: self.entity, insertInto: context)
        
        guard let context2: NSManagedObjectContext = dataStore else {
            
        }
        
        guard let name = name else {
            preconditionFailure("could not add exercise; no name provided")
        }
        newModelInstance.setValue(name, forKey: "name")
        
        guard let exerciseType = exerciseType else {
            preconditionFailure("could not add exercise; no exercise type provided")
        }
        newModelInstance.setValue(exerciseType, forKey: "exerciseTypes")
        
        if let url = url {
            newModelInstance.setValue(url, forKey: "url")
        }

        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure("failed to save context after adding an exercise")
            }
        }
        
    }
    
    func updateWith(name: String?, exerciseType: ExerciseTypeModel?, url: String?) {
        
        
    }
}


extension ExerciseType: Model, ExerciseTypeModel {
    
    static func generateQuery() -> Query {
        let request: NSFetchRequest = self.fetchRequest()
        return request
    }
    
    static func generateSortDescriptor(forKey key: String, ascending: Bool) -> NSSortDescriptor {
        let sortDescriptor = NSSortDescriptor(key: key, ascending: ascending)
        return sortDescriptor
    }
    
    func addWith(name: String?) {
        <#code#>
    }
    
    func updateWith(name: String?) {
        <#code#>
    }
    
    
}
