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
        
        //Set up a request that when fetched, will return Exercise objects sorted alphabetically
        // regardless of case
        let request = NSFetchRequest<Exercise>(entityName: "Exercise")
        request.returnsObjectsAsFaults = false
        
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        //clear all items from the array that will hold the fetched records
        exercisesInWorkoutJournalDataStore.removeAll()
        
        //fetch records from Core Data
        do {
            let result = try context.fetch(request)
            
            exercisesInWorkoutJournalDataStore = result
        
        } catch {
            print("fetch from Core Data failed")
        }
        
    }
    
    func deleteRecordInCoreData(exercise: NSManagedObject) {
        
        let context = workoutJournalDataStore.persistentContainer.viewContext
        context.delete(exercise)
        workoutJournalDataStore.saveContext()
    }
    
    
    
    
}
