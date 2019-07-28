//
//  WorkoutsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class WorkoutsViewModel {
    

    // Core Data data store will be injected into the variable from the
    // parent view controller, through the tab bar controller from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!

    // Set up an array of Workout objects
    //  to contain Workout records fetched from Core Data data store
    var workoutsInDataStore: [Workout] = []

    // Set up an array of Exercises
    //  to contain Exercise objects fetched from Core Data data store
    var exercisesInDataStore: [Exercise] = []

    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
        print("WorkoutsViewModel initializer was called")
    }

    func fetchWorkouts() {
        workoutsInDataStore = workoutJournalDataStore.fetchAllModelsOfType(Workout.self)
        print("fetch called to get workouts in data store")
    }

}
