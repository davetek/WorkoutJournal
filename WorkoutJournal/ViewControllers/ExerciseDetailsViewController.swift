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
    
    
    //data for typeField UIPickerView
    let exerciseTypes = ["Aerobic", "Calisthenics", "Core", "Weight-Training"]
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let button = sender as? UIBarButtonItem, button == saveButton else {
            return
        }
        
        
        //FIXME: call function to validate name within guard else block to display alert if name is invalid
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
