//
//  ExerciseTypeDetailsViewModel.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/18/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import CoreData

class ExerciseTypeDetailsViewModel {
    
    
    // Core Data data store will be injected into the variable from the
    // parent view controller, through the tab bar controller from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    //data will be injected at initialization
    var exerciseTypeBeingEdited: ExerciseType?
    
    // Set up an array of Exercise types
    //  to contain ExerciseType objects fetched from Core Data data store
    var exerciseTypesInDataStore: [ExerciseType] = []
    
    init(dataStore: WorkoutJournalDataStore) {
        self.workoutJournalDataStore = dataStore
    }
    
    
    //class initializer
    init(dataStore: WorkoutJournalDataStore?, exerciseTypeSelected: ExerciseType?) {
        self.workoutJournalDataStore = dataStore
        self.exerciseTypeBeingEdited = exerciseTypeSelected
        
        fetchExerciseTypes()
    }
    
    //convenience initializer for initializing a vm without a saved exercise, if an exercise is being added
    convenience init(dataStore: WorkoutJournalDataStore?) {
        self.init(dataStore: dataStore,
                  exerciseTypeSelected: nil)
    }
    
    func fetchExerciseTypes() {
        exerciseTypesInDataStore = workoutJournalDataStore.fetchRecordsFrom(ofType: ExerciseType.self)
    }
    
    func validate(exerciseTypeName: String?) -> Bool {
        //test if new exercise type name exists
        guard let exerciseTypeName = exerciseTypeName else {
            return false
        }
        
        //test if new exercise name value is empty string
        guard exerciseTypeName.isEmpty == false else {
            return false
        }
        
        if exerciseTypesInDataStore.contains(where:{$0.name?.lowercased() == exerciseTypeName.lowercased()}) {
            return false
        } else {
            return true
        }
        
    }
    
    func addExerciseType(withName name: String?) {
        if let typeName = name {
            workoutJournalDataStore.addRecord(ofType: ExerciseType.self, withAttributes: ["name": typeName])
        } else {
            print("no exercise type was provided")
        }
    }
    
    func updateExerciseType(_ exerciseType: ExerciseType, withFields fields: [String: Any]) {
        workoutJournalDataStore.updateForAnyPropertyTypes(object: exerciseType, withFields: fields)
    }
    

}
