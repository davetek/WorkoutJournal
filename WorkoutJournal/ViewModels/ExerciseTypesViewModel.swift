//
//  ExerciseTypesViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/11/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseTypesViewModel {
    
    // Core Data data store will be injected into the variable from the app delegate
    // through the ExercisesViewController
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
    }
    
}
