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
    
    // Core Data data store will be injected into the variable from the app delegate
    // through the ExercisesViewController
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Set up an array of Exercise objects
    //  to contain Exercises records fetched from Core Data data store
    var exercisesInWorkoutJournalDataStore: [Exercise] = []
    
    // Set up an array of Exercise types
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInWorkoutJournalDataStore: [ExerciseType] = []
    
    
    //get exercise records from Core Data data store
    func fetchExercisesFromCoreData()  {
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
    
    //get exercise type records from Core Data data store
    func fetchExerciseTypesFromCoreData()  {
        let context = workoutJournalDataStore.persistentContainer.viewContext
        
        //Set up a request that when fetched, will return ExerciseType objects sorted alphabetically
        // regardless of case
        let request = NSFetchRequest<ExerciseType>(entityName: "ExerciseType")
        request.returnsObjectsAsFaults = false
        
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        request.sortDescriptors = [sort]
        
        //clear all items from the array that will hold the fetched records
        exerciseTypesInWorkoutJournalDataStore.removeAll()
        
        //fetch records from Core Data
        do {
            let result = try context.fetch(request)
            
            exerciseTypesInWorkoutJournalDataStore = result
            
        } catch {
            print("fetch from Core Data failed")
        }
    }
    
    func addExerciseTypeToCoreData(exerciseTypeName: String?) {
        
        // add a record to Core Data data store
        let context = workoutJournalDataStore.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseType", in: context)
        let newExerciseType = NSManagedObject(entity: entity!, insertInto: context)
        
        newExerciseType.setValue(exerciseTypeName, forKey: "name")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
    }
    
    func deleteRecordInCoreData(exercise: NSManagedObject) {
        
        let context = workoutJournalDataStore.persistentContainer.viewContext
        context.delete(exercise)
        workoutJournalDataStore.saveContext()
    }
    
}

