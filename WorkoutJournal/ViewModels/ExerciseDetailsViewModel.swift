//
//  ExerciseDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 2/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseDetailsViewModel {
    
    let currentExerciseNames: [String]
    
    //data for typeField UIPickerView
    // data will be set on object in initialization parameter
    var exerciseTypes: [String]
    
    // Core Data data store will be injected into the variable from the parent view controller
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected in this variable at segue
    var exercise: Exercise?
    
    init(currentExerciseNames: [String], exerciseTypes: [String]) {
        self.currentExerciseNames = currentExerciseNames
        self.exerciseTypes = exerciseTypes
    }
    
    // (future: could use enum cases to represent validation failures)
    func validateExerciseName(_ exerciseName: String?) -> Bool {
        if let nonNullExerciseName = exerciseName {
            
            if nonNullExerciseName.isEmpty {
                return false
            }
            else if !currentExerciseNames.contains(nonNullExerciseName) {
                return true
            } else {
                return false
            }
                    
        } else {
            //exerciseName is nil
            return false
        }
    }
    
    // (future: could use enum cases to represent validation failures)
    func validateExerciseType(_ exerciseType: String?) -> Bool {
        if let nonNullExerciseType = exerciseType {
            
            if nonNullExerciseType.isEmpty {
                return false
            }
            else if exerciseTypes.contains(nonNullExerciseType) {
                return true
            } else {
                return false
            }
            
        } else {
            //exerciseType is nil
            return false
        }
    }
    
    func addRecordToCoreData(exerciseName: String?, exerciseType: String?, exerciseUrl: String?) {
        
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
    
    
    
}

