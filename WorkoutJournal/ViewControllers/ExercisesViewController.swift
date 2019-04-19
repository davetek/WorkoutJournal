//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit
import CoreData
import SafariServices

class ExercisesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //view model
    var exercisesViewModel: ExercisesViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
        //if in editing mode
        if self.tableView.isEditing {
            
            //change the button title
            if sender.title != nil {
                sender.title = "Edit"
            }
            
            //turn off editing mode
            self.tableView.isEditing = false
            
        } else {
            //change the button title
            if sender.title != nil {
                sender.title = "Done"
            }
            
            //enter editing mode
            self.tableView.isEditing = true
        }
        
    }
    
    func wasAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    

    
    func openBrowserWithURL(_ url: URL) {
        let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        let safariViewController = SFSafariViewController(url: url, configuration: config)
        present(safariViewController, animated: true)
    }
    
    
    //pre-populate Core Data with exercise types
    func addBasicExerciseTypesToCoreData() {
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Aerobic")
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Calisthenics")
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Core")
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Stretching")
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Weight Training")
        exercisesViewModel.addExerciseTypeToCoreData(exerciseTypeName: "Yoga")
    }

    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        exercisesViewModel.fetchExercisesFromCoreData()
        exercisesViewModel.fetchExerciseTypesFromCoreData()
        
        let appWasLaunchedBefore: Bool = wasAppAlreadyLaunchedOnce()
        if appWasLaunchedBefore == false {
            addBasicExerciseTypesToCoreData()
        }
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataStore.exercises.count
        return exercisesViewModel.exercisesInDataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ExerciseCell", for: indexPath) as! ExerciseCell
        
        cell.cellRow = indexPath.row

        cell.cellDelegate = self
        
        let exercise = exercisesViewModel.exercisesInDataStore[indexPath.row]
        let exerciseName = exercise.name
        let exerciseType = exercise.exerciseTypes
        
        
        cell.nameLabel.text = exerciseName
        cell.typeLabel.text = exerciseType?.name
        
        if let exerciseUrl = exercise.url {
            if exerciseUrl.isEmpty == false {
                cell.browserButton.isEnabled = true
            } else {
                cell.browserButton.isEnabled = false
            }
        } else {
            cell.browserButton.isEnabled = false
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        //if add button was tapped
        case Constants.idForSegueToAddExerciseDetails?:
            let exerciseDetailsNavController = segue.destination as! UINavigationController
            let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
            
            //get list of exercise names and exercise type names and use them to create an ExerciseDetailsViewModel instance
            let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercises: exercisesViewModel.exercisesInDataStore,
                                                                    exerciseTypes: exercisesViewModel.exerciseTypesInDataStore)
            
            exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore
            exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
        
            
        //if an exercise was tapped
        case Constants.idForSegueToExerciseDetails?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the exercise details view model
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                
                //create an ExerciseDetailsViewModel instance
                let exerciseDetailsViewModel = ExerciseDetailsViewModel(exercises: exercisesViewModel.exercisesInDataStore,
                                                                        exerciseTypes: exercisesViewModel.exerciseTypesInDataStore)
                
                let exerciseSelected: Exercise = exercisesViewModel.exercisesInDataStore[row]
                exerciseDetailsViewModel.exercise = exerciseSelected
                
                exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore

                exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
                print("at end of prepare(for:sender:)")
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    
    //method called when a change is made to the table in edit mode
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    
        //if table view is asking to commit a delete command
        if editingStyle == .delete {

            let exerciseSelected: Exercise = exercisesViewModel.exercisesInDataStore[indexPath.row]
            
            //delete the associated record from Core Data
            exercisesViewModel.deleteRecordInCoreData(exercise: exerciseSelected)
            
            exercisesViewModel.fetchExercisesFromCoreData()
            tableView.reloadData()
        }
        
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        exercisesViewModel.fetchExercisesFromCoreData()
        tableView.reloadData()
    }
    
}

extension ExercisesViewController: ExerciseCellDelegate {
    
    func didTapViewInBrowser(cellRow: Int) {
        let exerciseForButtonTapped: Exercise = exercisesViewModel.exercisesInDataStore[cellRow]
        
        if let exerciseUrl = exerciseForButtonTapped.url {
            if let url = URL(string: exerciseUrl) {
                openBrowserWithURL(url)
            }
        } else {
            print("no URL for this exercise")
        }
    }
}

