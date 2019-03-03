//
//  ExerciseDetailsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExerciseDetailsViewController: UIViewController {
    
    
    //state should be set upon segue via parent view controller
    var addingNewRecord: Bool!
    
    //initial value of name field
    var nameFieldTextInitialValue = ""
    
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
                nameFieldTextInitialValue = exerciseName
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
            
        
        //check if saving changes to an existing record's name field; if so, continue
        // if the name field contained text when the screen loaded, AND that text has been modifield,
        // run validation on the name; otherwise, skip name validation
        if nameFieldTextInitialValue.isEmpty == false &&  nameField.text != nameFieldTextInitialValue {
            
            guard exerciseDetailsViewModel.validateExerciseName(nameField.text) else {
                let alertMessage = "There was a problem with the exercise name; please try again"
                
                let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
            }
            
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
        
        if addingNewRecord {
            //add exercise to Core Data as a new record
            print("adding a record")
            exerciseDetailsViewModel.addRecordToCoreData(exerciseName: nameField.text, exerciseType: typeField.text, exerciseUrl: urlField.text)
        } else {
            //save changes to existing exercise in Core Data
            print("editing existing record")
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
