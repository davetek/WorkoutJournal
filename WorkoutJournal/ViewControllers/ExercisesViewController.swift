//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit
import CoreData

class ExercisesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //view model
    var exercisesViewModel: ExercisesViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    @IBAction func toggleEditingMode(_ sender: Any) {
        //if in editing mode
        if self.tableView.isEditing {
            
            //turn off editing mode
            print("tapped Edit button while in editing mode")
            self.tableView.isEditing = false
        } else {
            
            //enter editing mode
            print("tapped Edit button while not in editing mode")
            self.tableView.isEditing = true
        }
        
    }

    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        exercisesViewModel.fetchFromCoreData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataStore.exercises.count
        return exercisesViewModel.exercisesInWorkoutJournalDataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercisesPrototypeCell", for: indexPath)

        
        let exercise = exercisesViewModel.exercisesInWorkoutJournalDataStore[indexPath.row]
        let exerciseName = exercise.name
        let exerciseType = exercise.type
        
        cell.textLabel?.text = exerciseName
        cell.detailTextLabel?.text = exerciseType
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        //if add button was tapped
        case Constants.idForSegueToAddExerciseDetails?:
            let exerciseDetailsNavController = segue.destination as! UINavigationController
            let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
            
            exerciseDetailsViewController.addingNewRecord = true
            
            let exerciseNamesList = exercisesViewModel.exercisesInWorkoutJournalDataStore.map { (exercise) -> String in
                return exercise.name!
            }
            let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: exerciseNamesList,
                                                                    exerciseTypes: exercisesViewModel.exerciseTypes)
            exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore
            exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
        
        //if an exercise was tapped
        case Constants.idForSegueToExerciseDetails?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the exercise details view model
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                
                exerciseDetailsViewController.addingNewRecord = false
                
                let exerciseNamesList = exercisesViewModel.exercisesInWorkoutJournalDataStore.map { (exercise) -> String in
                    return exercise.name!
                }
                
                let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: exerciseNamesList,
                                                                        exerciseTypes: exercisesViewModel.exerciseTypes)
                
                let exerciseSelected: Exercise = exercisesViewModel.exercisesInWorkoutJournalDataStore[row]
                exerciseDetailsViewModel.exercise = exerciseSelected
                
                exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore
                
                exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    
    //method called when a change is made to the table in edit mode
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
            
        //if table view is asking to commit a delete command
        if editingStyle == .delete {

            let exerciseSelected: Exercise = exercisesViewModel.exercisesInWorkoutJournalDataStore[indexPath.row]
            
            //delete the associated record from Core Data
            exercisesViewModel.deleteRecordInCoreData(exercise: exerciseSelected)
            
            exercisesViewModel.fetchFromCoreData()
            tableView.reloadData()
        }
        
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        exercisesViewModel.fetchFromCoreData()
        tableView.reloadData()
    }
    
  
    
    
}
