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
    
    //get exercise records from Core Data data store
    func fetchExercisesFromCoreData()  {
        let context = workoutJournalDataStore.context
        
        //Set up a request for all NSManagedObject objects of type Exercise
        let request: NSFetchRequest = Exercise.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        //create a sort descriptor to sort ascending alphabetically
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        //assign the new sort descriptor to the request
        request.sortDescriptors = [sort]
        
        //clear all items from the array that will hold the fetched records
        exercisesInDataStore.removeAll()
        
        //fetch records from Core Data & assign to variable if successful
        do {
            let result = try context.fetch(request)
            exercisesInDataStore = result
            
        } catch {
            print("fetch from Core Data failed")
        }
    }
    
    
    //get exercise type records from Core Data data store
    func fetchExerciseTypesFromCoreData()  {
        let context = workoutJournalDataStore.context
        
        //Set up a request for all NSManagedObject objects of type ExerciseType
        let request: NSFetchRequest = ExerciseType.fetchRequest()
        request.returnsObjectsAsFaults = false
        
        //create a sort descriptor to sort ascending alphabetically
        let sort = NSSortDescriptor(key: "name",
                                    ascending: true,
                                    selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))
        
        //assign the new sort descriptor to the request
        request.sortDescriptors = [sort]
        
        //clear all items from the array that will hold the fetched records
        exerciseTypesInDataStore.removeAll()
        
        //fetch records from Core Data & assign to variable if successful
        do {
            let result = try context.fetch(request)
            exerciseTypesInDataStore = result
            
        } catch {
            print("fetch from Core Data failed")
        }
    }
    
    
    func addExerciseTypeToCoreData(exerciseTypeName: String?) {
        
        // add a record to Core Data data store
        let context = workoutJournalDataStore.context
        let entity = NSEntityDescription.entity(forEntityName: "ExerciseType", in: context)
        let newExerciseType = NSManagedObject(entity: entity!, insertInto: context)
        
        newExerciseType.setValue(exerciseTypeName, forKey: "name")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
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

