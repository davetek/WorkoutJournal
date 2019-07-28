//
//  WorkoutDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/27/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class WorkoutDetailsViewModel {
    
    
    // Core Data data store will be injected into the variable from the
    // parent view controller, through the tab bar controller from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected at initialization
    var WorkoutBeingEdited: Workout?
    
    // Set up an array of Exercise types
    //  to contain ExerciseType objects fetched from Core Data data store
    var workoutsInDataStore: [Workout] = []
    
    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
    }
    
    
    //class initializer
    init(dataStore: WorkoutJournalDataStore?, workoutSelected: Workout?) {
        self.workoutJournalDataStore = dataStore
        self.WorkoutBeingEdited = workoutSelected
        
        fetchWorkouts()
    }
    
    //convenience initializer for initializing a vm without a saved exercise, if a workout is being added
    convenience init(dataStore: WorkoutJournalDataStore?) {
        self.init(dataStore: dataStore,
                  workoutSelected: nil)
    }
    
    func fetchWorkouts() {
        workoutsInDataStore = workoutJournalDataStore.fetchAllModelsOfType(Workout.self)
    }
    
    func validate(workoutName: String?) -> Bool {
        //test if new workout name exists
        guard let workoutName = workoutName else {
            return false
        }
        
        //test if new workout name value is empty string
        guard workoutName.isEmpty == false else {
            return false
        }
        
        if workoutsInDataStore.contains(where:{$0.name?.lowercased() == workoutName.lowercased()}) {
            return false
        } else {
            return true
        }
        
    }
    
    func addWorkout(withName name: String?) {
        if let typeName = name {
            workoutJournalDataStore.addRecord(ofType: Workout.self, withAttributes: ["name": typeName])
        } else {
            print("no workout was provided")
        }
    }
    
    func updateWorkout(_ workout: ExerciseType, withFields fields: [String: Any]) {
        workoutJournalDataStore.updateForAnyPropertyTypes(object: workout, withFields: fields)
    }
    
    
}

