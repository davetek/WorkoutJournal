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
    
    func delete<T>(dataObject: T) where T : Model {
        
        let context = self
        context.delete(dataObject as! NSManagedObject)
        do {
            try context.save()
        } catch let error {
            if error._code == 1600 {
                preconditionFailure("cannot delete model instance; it is referred to by another model instance")
                context.rollback()
            } else {
                preconditionFailure("Error when attempting to delete model instance: \(error)")
            }
        }
    }
    
    func saveChanges() {
        let context = self
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure("Error occured when attempting to save data")
            }
        }
    }
    
}

extension NSFetchRequest: Query {
    
    @objc var fromModelName: String? {
        get {
            return self.entityName
        }
    }
    
    typealias SortDescriptor = NSSortDescriptor
    
   @objc var orderBy: [NSSortDescriptor]? {
        get {
            return self.sortDescriptors
        }
        set {
            self.sortDescriptors = newValue
        }
    }
    
    typealias Predicate = NSPredicate
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
    
    static func generateQuery() -> NSFetchRequest<Exercise> {
        let request: NSFetchRequest<Exercise> = self.fetchRequest()
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
        
        guard let dataStore = dataStore else {
            preconditionFailure("could not add exercise; no data store provided")
        }
        let context = dataStore as! NSManagedObjectContext
        
        let newModelInstance = NSManagedObject(entity: self.entity(), insertInto: context)
        
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
    
    //instance method; context can be obtained directly from the Exercise instance
    func updateWith(name: String?, exerciseType: ExerciseTypeModel?, url: String?) {
        
        guard let context = self.managedObjectContext else {
            preconditionFailure("cannot obtain context from the exercise instance")
        }
        
        if let name = name {
            self.setValue(name, forKey: "name")
        }
        
        if let exerciseType = exerciseType {
            let exerciseTypeEntity = exerciseType as! NSManagedObject
            self.setValue(exerciseTypeEntity, forKey: "exerciseTypes")
        }
        
        if let url = url {
            self.setValue(url, forKey: "url")
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure("failed to save update to exercise")
            }
        }
        
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
    
    func addWith(name: String?, dataStore: DataStore?) {
       
        guard let dataStore = dataStore else {
            preconditionFailure("could not add exercise; no data store provided")
        }
        let context = dataStore as! NSManagedObjectContext
        
        let newModelInstance = NSManagedObject(entity: self.entity, insertInto: context)
        
        guard let name = name else {
            preconditionFailure("could not add exercise; no name provided")
        }
        newModelInstance.setValue(name, forKey: "name")
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure("failed to save context after adding an exercise")
            }
        }
    }
    
    func updateWith(name: String?) {
        
        guard let context = self.managedObjectContext else {
            preconditionFailure("cannot update exercise type; context not available")
        }
        
        if let name = name {
            self.setValue(name, forKey: "name")
        }
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                preconditionFailure("failed to save update to exercise type")
            }
        }
    }
    
    
}
