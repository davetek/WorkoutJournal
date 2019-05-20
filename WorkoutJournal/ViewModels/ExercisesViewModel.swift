//
//  ExercisesViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 2/19/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExercisesViewModel {
    
    //data for typeField UIPickerView in ExerciseDetailsViewModel
    //let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]
    
    // Core Data data store will be injected into the variable from the
    // parent view controller, through the tab bar controller from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Set up an array of Exercise objects
    //  to contain Exercises records fetched from Core Data data store
    var exercisesInDataStore: [Exercise] = []
    
    // Set up an array of Exercise types
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInDataStore: [ExerciseType] = []
    
    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
    }
    
    func fetchExercises() {
        exercisesInDataStore = workoutJournalDataStore.fetchRecordsFrom(ofType: Exercise.self)
    }
    

    
    
    func delete(dataObject: NSManagedObject) {
        
        let context = workoutJournalDataStore.context
        context.delete(dataObject)
        do {
            try context.save()
        } catch _ {
            print("Core Data failed to delete the data object")
        }
    }
    
}

