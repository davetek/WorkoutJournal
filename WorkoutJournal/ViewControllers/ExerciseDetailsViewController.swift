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
    @IBOutlet var urlField: UITextField!
    
    
    //data for typeField UIPickerView
    let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]
    
    //selected type
    var selectedType: String?
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //data will be injected in this variable at segue
    var exercise: [String: String]?
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let exerciseTapped = exercise {
            if let exerciseName = exerciseTapped["name"] {
                print("exerciseName from Core Data: ", exerciseName)
                nameField.text = exerciseName
            }
            
            if let exerciseType = exerciseTapped["type"] {
                print("exerciseType from Core Data: ", exerciseType)
                typeField.text = exerciseType
            }
            
            if let exerciseUrl = exerciseTapped["url"] {
                print("exerciseUrl from Core Data: ", exerciseUrl)
                urlField.text = exerciseUrl
            }
        }
        
        createTypePicker()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            return
        }
        
        // add a record to Core Data data store
        let context = workoutJournalDataStore.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Exercise", in: context)
        let newExercise = NSManagedObject(entity: entity!, insertInto: context)
        newExercise.setValue(nameField.text, forKey: "name")
        newExercise.setValue(typeField.text, forKey: "type")
        newExercise.setValue(urlField.text, forKey: "url")
        print("add record to Core Data data store:")
        print("NSManagedObject newExercise :", newExercise.value(forKey: "name") as! String)
        print("NSManagedObject newExercise :", newExercise.value(forKey: "type") as! String)
        print("NSManagedObject newExercise :", newExercise.value(forKey: "url") as! String)

        
        // save the data to Core Data
        workoutJournalDataStore.saveContext()
        
    }
    
    func createTypePicker() {
        let typePicker = UIPickerView()
        typePicker.delegate = self
        
        typeField.inputView = typePicker
        typePicker.backgroundColor = .white
    }
}


//extension for picker view
extension ExerciseDetailsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return exerciseTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = exerciseTypes[row]
        typeField.text = selectedType
    }
    
    
}
