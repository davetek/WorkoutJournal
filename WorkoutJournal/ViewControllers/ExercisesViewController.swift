//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit
import CoreData

class ExercisesViewController: UIViewController, UITableViewDataSource{
    
    //view model
    var exercisesViewModel: ExercisesViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
    }

    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
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
        case Constants.idForSegueToAddExerciseDetails?:
            let exerciseDetailsNavController = segue.destination as! UINavigationController
            let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
            
            
            let exerciseNamesList = exercisesViewModel.exercisesInWorkoutJournalDataStore.map { (exercise) -> String in
                return exercise.name!
            }
            let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: exerciseNamesList)
            exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore
            exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
            
        case Constants.idForSegueToExerciseDetails?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the exercise details view model
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                
                let exerciseNamesList = exercisesViewModel.exercisesInWorkoutJournalDataStore.map { (exercise) -> String in
                    return exercise.name!
                }
                
                let exerciseDetailsViewModel = ExerciseDetailsViewModel(currentExerciseNames: exerciseNamesList)
                
                let exerciseSelected: Exercise = exercisesViewModel.exercisesInWorkoutJournalDataStore[row]
                exerciseDetailsViewModel.exercise = exerciseSelected
                
                exerciseDetailsViewModel.workoutJournalDataStore = exercisesViewModel.workoutJournalDataStore
                
                exerciseDetailsViewController.exerciseDetailsViewModel = exerciseDetailsViewModel
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        //print("unwind with changes")
        exercisesViewModel.fetchFromCoreData()
        tableView.reloadData()
    }
    
  
    
    
}
