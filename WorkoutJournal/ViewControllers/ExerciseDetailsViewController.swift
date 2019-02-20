//
//  ExerciseDetailsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {
    
    //View Model
    var exerciseDetailsViewModel: ExerciseDetailsViewModel!
    
    @IBOutlet var nameField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var urlField: UITextField!
    
    
    //selected type
    var selectedType: String?
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let exerciseTapped = exerciseDetailsViewModel.exercise {
            if let exerciseName = exerciseTapped.name {
                nameField.text = exerciseName
            }
            
            if let exerciseType = exerciseTapped.type {
                typeField.text = exerciseType
            }
            
            if let exerciseUrl = exerciseTapped.url {
                urlField.text = exerciseUrl
            }
        }
        
        createTypePicker()
        
    }
    
    //run checks on user data to determine if the prepare method for the 'unwind with changes'
    // if result is true, prepare method is run
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        if identifier == Constants.idForUnwindWithChangesSegueToExercises {
            print("segue between this screen and exercises screen may be executed")
            
            //run validation on name text entered and return true if passes; false otherwise
            if exerciseDetailsViewModel.validateExerciseName(nameField.text) {
                
                return true
                
            } else {
                //do not perform segue; display alert popup instead
                print("validation on name field failed")
                return false
            }
        } else {
            print("segue identifier for shouldPerform segue did not match condition")
            return true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            return
        }

        
        //commit exercise to Core Data
        exerciseDetailsViewModel.addRecordToCoreData(exerciseName: nameField.text, exerciseType: typeField.text, exerciseUrl: urlField.text)

        
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
        return exerciseDetailsViewModel.exerciseTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return exerciseDetailsViewModel.exerciseTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedType = exerciseDetailsViewModel.exerciseTypes[row]
        typeField.text = selectedType
    }
    
    
}
