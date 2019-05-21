//
//  ExerciseTypesViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/11/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseTypesViewModel {
    
    // Core Data data store will be injected into the variable from the tab bar controller
    // through the ExerciseTypesViewController
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Set up an array of Exercise types
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInDataStore: [ExerciseType] = []
    
    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
        
        workoutJournalDataStore.context.refreshAllObjects()
        
        fetchExerciseTypes()
    }
    
    
    
    func fetchExerciseTypes() {
        exerciseTypesInDataStore = workoutJournalDataStore.fetchRecordsFrom(ofType: ExerciseType.self)
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
