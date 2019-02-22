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
    let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]
    
    // Core Data data store will be injected into the variable from the app delegate
    // through the ExercisesViewController
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Set up an array of Exercise objects
    //  to contain Exercises records fetched from Core Data data store
    var exercisesInWorkoutJournalDataStore: [Exercise] = []
    
    //get records from Core Data data store
    func fetchFromCoreData()  {
        let context = workoutJournalDataStore.persistentContainer.viewContext
        
        //Liam 2019-02-10 could set as <Exercise> result
        let request = NSFetchRequest<Exercise>(entityName: "Exercise")
        request.returnsObjectsAsFaults = false
        
        
        //clear all items from the array that will hold the fetched records
        exercisesInWorkoutJournalDataStore.removeAll()
        
        do {
            let result = try context.fetch(request)
            
            exercisesInWorkoutJournalDataStore = result
        
        } catch {
            print("fetch from Core Data failed")
        }
        
    }
    
    
    
    
}
