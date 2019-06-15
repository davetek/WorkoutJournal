//
//  ExerciseDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 2/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseDetailsViewModel {
    
    // Core Data data store will be injected at initialization
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected at initialization
    var exerciseBeingEdited: Exercise?
    
    // Set up an array of Exercise objects to injected at initialization
    //  to contain Exercises records fetched from Core Data data store
    var exercisesInDataStore: [Exercise] = []
    
    // Set up an array of Exercise types to be injected at initialization
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInDataStore: [ExerciseType] = []
    
    // Set up variable to retain the exercise type specified,
    //  from parent view controller or from type picker
    var specifiedExerciseType: ExerciseType?
    
    
    //class initializer
    init(exercises: [Exercise], exerciseTypes: [ExerciseType], dataStore: WorkoutJournalDataStore?, exerciseSelected: Exercise?) {
        self.exercisesInDataStore = exercises
        self.exerciseTypesInDataStore = exerciseTypes
        self.workoutJournalDataStore = dataStore
        self.exerciseBeingEdited = exerciseSelected
        
        if exerciseSelected != nil {
            specifiedExerciseType = exerciseSelected?.exerciseTypes
            
            
        }
    }
    
    //convenience initializer for initializing a vm without a saved exercise, if an exercise is being added
    convenience init(exercises: [Exercise], exerciseTypes: [ExerciseType], dataStore: WorkoutJournalDataStore?) {
        self.init(exercises: exercises,
                  exerciseTypes: exerciseTypes,
                  dataStore: dataStore,
                  exerciseSelected: nil)
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
        
        if exercisesInDataStore.contains(where:{$0.name?.lowercased() == exerciseName.lowercased()}) {
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




    func addExerciseWith(exerciseName: String?, exerciseType: ExerciseType?, exerciseUrl: String?) {
        
        guard let name = exerciseName else {
            fatalError("exercise name was not provided")
        }
        
        guard let type = exerciseType else {
            fatalError("exercise type was not provided")
        }
        
        if let url = exerciseUrl {
            workoutJournalDataStore.addRecord(ofType: Exercise.self, withAttributes: ["name": name,
                                                                                  "exerciseTypes": type,
                                                                                  "url": url])
        } else {
            workoutJournalDataStore.addRecord(ofType: Exercise.self, withAttributes: ["name": name, "exerciseTypes": type])
        }
        
    }
    
    
    func editRecordInCoreData(exerciseName: String?, exerciseType: ExerciseType?, exerciseUrl: String?) {
        
        guard let exercise = exerciseBeingEdited else {
            preconditionFailure("could not access exercise in Core Data")
        }
        
        exercise.setValue(exerciseName, forKey: "name")
        exercise.setValue(exerciseType, forKey: "exerciseTypes")
        exercise.setValue(exerciseUrl, forKey: "url")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
        
    }
    
}




