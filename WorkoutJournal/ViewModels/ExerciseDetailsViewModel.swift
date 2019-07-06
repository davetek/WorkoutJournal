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
    
    init(dataStore: WorkoutJournalDataStore?, exerciseSelected: Exercise?) {
        
        guard let dataStore = dataStore else {
            preconditionFailure("no data store passed to ExerciseDetailsViewModel initializer")
        }
        
        self.exercisesInDataStore = dataStore.fetchAllModelsOfType(Exercise.self)
        self.exerciseTypesInDataStore = dataStore.fetchAllModelsOfType(ExerciseType.self)
        
        self.workoutJournalDataStore = dataStore
        
        self.exerciseBeingEdited = exerciseSelected
        if exerciseSelected != nil {
            specifiedExerciseType = exerciseSelected?.exerciseTypes
        }
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
    
    
    func updateExercise(_ exercise: inout Exercise, exerciseName: String?, exerciseType: ExerciseType?, exerciseURL: String?) {
        
        var fieldsToUpdate = [WritableKeyPath<Exercise, String?>: String?]()
        
        if let name = exerciseName {
            fieldsToUpdate[\Exercise.name] = name
        }
        
        if let url = exerciseURL {
            fieldsToUpdate[\Exercise.url] = url
        }
        
        guard fieldsToUpdate.count > 0 else {
            fatalError("no fields were provided to update")
        }
        
        workoutJournalDataStore.update(object: &exercise, withFields: fieldsToUpdate)
        
    }
    
    
    func updateExerciseWithAnyPropertyTypes(_ exercise: Exercise, exerciseName: String?, exerciseType: ExerciseType?, exerciseURL: String?) {
        
        var fieldsToUpdate = [String: Any]()
        
        if let name = exerciseName {
            fieldsToUpdate["name"] = name
        }
        
        if let type: ExerciseType = exerciseType {
            fieldsToUpdate["exerciseTypes"] = type
        }
        
        if let url = exerciseURL {
            fieldsToUpdate["url"] = url
        }
        
        guard fieldsToUpdate.count > 0 else {
            fatalError("no fields were provided to update")
        }
        
        workoutJournalDataStore.updateForAnyPropertyTypes(object: exercise, withFields: fieldsToUpdate)
        
    }
    
    
    
    
    
}




