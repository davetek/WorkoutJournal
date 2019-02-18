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
    
    // Core Data data store will be injected into the variable from the parent view controller
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected in this variable at segue
    var exercise: [String: String]?
    
    init(currentExerciseNames: [String]) {
        self.currentExerciseNames = currentExerciseNames
    }
    
    //TO DO: make paramater an optional
    // add unit test to test for nil name
    // (future: could use enum cases to represent validation failures)
    func validateExerciseName(_ exerciseName: String) -> Bool {
        if exerciseName.isEmpty {
            return false
        }
        else if !currentExerciseNames.contains(exerciseName) {
            return true
        } else {
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

