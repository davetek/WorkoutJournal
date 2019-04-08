//
//  ExerciseDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 2/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseDetailsViewModel {
    
    // Core Data data store will be injected into the variable from the parent view controller
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected in this variable at segue
    var exercise: Exercise?
    
    // Set up an array of Exercise objects to injected in the initializer
    //  to contain Exercises records fetched from Core Data data store
    var exercisesInDataStore: [Exercise] = []
    
    // Set up an array of Exercise types to be injected in the initializer
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInDataStore: [ExerciseType] = []
    
    init(exercises: [Exercise], exerciseTypes: [ExerciseType]) {
        self.exercisesInDataStore = exercises
        self.exerciseTypesInDataStore = exerciseTypes
    }
    
    
    func validate(exerciseName: String?) -> Bool {
        
        //test if new exercise name exists
        guard let exerciseName = exerciseName else {
            return false
        }
        
        //test if new exercise name value is empty string
        guard exerciseName.isEmpty == false else {
            return false
        }
        
        if exercisesInDataStore.contains(where: {$0.name == exerciseName.lowercased()}) {
            return false
        } else {
            return true
        }
        
    }

    
    
    func validateExerciseType(_ exerciseType: String?) -> Bool {
        if let exerciseType = exerciseType {
            
            if exerciseType.isEmpty {
                return false
            }
            else if exerciseTypesInDataStore.contains(where: {$0.name == exerciseType}) {
                return true
            } else {
                return false
            }
            
        } else {
            //exerciseType is nil
            return false
        }
    }
    
    func validateExerciseUrl(_ exerciseUrl: String?) -> Bool {
        
        guard let urlString = exerciseUrl else {
            return false
        }
                
        guard let urlComponents = URLComponents(string: urlString) else {
            return false
        }
        
        guard let scheme = urlComponents.scheme else {
            return false
        }
        
        guard scheme == "http" || scheme == "https" else {
            return false
        }
        
        guard urlComponents.host != nil else {
            return false
        }
        
        return true
    }




    
    func addExerciseRecordToCoreData(exerciseName: String?, exerciseType: String?, exerciseUrl: String?) {
        
        // add a record to Core Data data store
        let context = workoutJournalDataStore.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
        let newExercise = NSManagedObject(entity: entity!, insertInto: context)
        
        newExercise.setValue(exerciseName, forKey: "name")
        newExercise.setValue(exerciseType, forKey: "type")
        newExercise.setValue(exerciseUrl, forKey: "url")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
    }
    
    
    func editRecordInCoreData(exerciseName: String?, exerciseType: String?, exerciseUrl: String?) {
        
        guard let exercise = exercise else {
            preconditionFailure("could not access exercise in Core Data")
        }
        
        exercise.setValue(exerciseName, forKey: "name")
        exercise.setValue(exerciseType, forKey: "type")
        exercise.setValue(exerciseUrl, forKey: "url")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
        
    }
    
}

