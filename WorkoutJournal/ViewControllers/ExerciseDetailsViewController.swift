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
        
        guard identifier == Constants.idForUnwindWithChangesSegueToExercises else {
            return true
        }
        
        //if an exercise is being edited, get its name
        if let currentNameForExercise = exerciseDetailsViewModel.exercise?.name {
            
            //get the index of the exercise's name from the array of current exercise names, and then remove the name from the array
            if let indexOfExistingExerciseName = exerciseDetailsViewModel.currentExerciseNames.firstIndex(of: currentNameForExercise.lowercased()) {
                exerciseDetailsViewModel.currentExerciseNames.remove(at: indexOfExistingExerciseName)
            }
        }
                
        guard exerciseDetailsViewModel.validate(exerciseName: nameField.text) else {
            let alertMessage = "There was a problem with the exercise name; please try again"
            
            let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        
        //run validation on exercise type
        guard exerciseDetailsViewModel.validateExerciseType(typeField.text) else {
            let alertMessage = "There was a problem with the exercise type; please try again"
            
            let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true)
            return false
        }
        
        if let urlFieldText = urlField.text {
            if !urlFieldText.isEmpty {
                guard exerciseDetailsViewModel.validateExerciseUrl(urlFieldText) else {
                    let alertMessage = "There was a problem with the exercise URL; please try again"
                    
                    let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return false
                }
            }
        }
        
        //validation passed; allow segue to be performed
        return true
    }
    
    //define items to execute when Save button is tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            return
        }
        
        //if exercise in view model is nil, user is adding a record; otherwise edit the exercise retained in the view model
        if exerciseDetailsViewModel.exercise == nil {
            //add exercise to Core Data as a new record
            exerciseDetailsViewModel.addRecordToCoreData(exerciseName: nameField.text, exerciseType: typeField.text, exerciseUrl: urlField.text)
        } else {
            //save changes to existing exercise in Core Data
            exerciseDetailsViewModel.editRecordInCoreData(exerciseName: nameField.text, exerciseType: typeField.text, exerciseUrl: urlField.text)
        }
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
