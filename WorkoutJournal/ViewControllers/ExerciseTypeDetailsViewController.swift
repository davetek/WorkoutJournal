//
//  ExerciseTypeDetailsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/17/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

class ExerciseTypeDetailsViewController: UIViewController {
    
    //View Model
    var exerciseTypeDetailsViewModel: ExerciseTypeDetailsViewModel!
    
    @IBOutlet var nameField: UITextField!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        if let exerciseTypeTapped = exerciseTypeDetailsViewModel.exerciseTypeBeingEdited {
            if let exerciseTypeName = exerciseTypeTapped.name {
                nameField.text = exerciseTypeName
            }
        }
    }
    
    //run checks on user data to determine if the prepare method for the 'unwind with changes'
    // is true, prepare method is run
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        
        guard identifier == Constants.idForUnwindWithChangesSegueToExercises else {
            return true
        }
        
        //if an exercise is being edited,
        if let currentNameForExerciseType = exerciseTypeDetailsViewModel.exerciseTypeBeingEdited?.name {
            
            //get its name and compare its lowercased name to the text in the name field, lowercased
            if nameField.text?.lowercased() == currentNameForExerciseType.lowercased() {
            } else {
                guard exerciseTypeDetailsViewModel.validate(exerciseTypeName: nameField.text) else {
                    let alertMessage = "There was a problem with the exercise type name; please try again"
                    
                    let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alert, animated: true)
                    return false
                }
            }
        } else {
            print("adding exercise type so performing name validation")
            guard exerciseTypeDetailsViewModel.validate(exerciseTypeName: nameField.text) else {
                let alertMessage = "There was a problem with the exercise name; please try again"
                
                let alert = UIAlertController(title: "Error", message: alertMessage, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true)
                return false
            }
        }
        
        //validation passed
        return true
    }
        
        
 
    
    //define items to execute when Save button is tapped
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            return
        }
        
        //if exercise in view model is nil, user is adding a record; otherwise edit the exercise retained in the view model
        if exerciseTypeDetailsViewModel.exerciseTypeBeingEdited == nil {
            //add exercise to Core Data as a new record
            exerciseTypeDetailsViewModel.addExerciseType(withName: nameField.text)
        } else {
            //save changes to existing exercise in Core Data
            if let exerciseTypeEdited = exerciseTypeDetailsViewModel.exerciseTypeBeingEdited {
                if let nameFieldText = nameField.text {
                    exerciseTypeDetailsViewModel.updateExerciseType(exerciseTypeEdited, withFields: ["name": nameFieldText])
                }
                

            }
        }
    }
}

