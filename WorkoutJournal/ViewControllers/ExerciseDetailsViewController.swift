//
//  ExerciseDetailsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit
import CoreData

class ExerciseDetailsViewController: UIViewController {
    
    // Core Data data store will be injected into the variable from the parent view controller
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //data will be injected in this variable at segue
    var exercise: [String: String]?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let exerciseTapped = exercise {
            if let exerciseName = exerciseTapped["name"] {
                nameField.text = exerciseName
            }
            
            if let exerciseType = exerciseTapped["type"] {
                typeField.text = exerciseType
            }
        }
        
        
       
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            print("cancel button tapped")
            return
        }
        print("ready to save data before unwind segue")
        
        // add a record to Core Data data store
        let context = workoutJournalDataStore.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
        let newExercise = NSManagedObject(entity: entity!, insertInto: context)
        newExercise.setValue(nameField.text, forKey: "name")
        newExercise.setValue(typeField.text, forKey: "type")
        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
        
    }
}
