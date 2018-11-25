//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController, UITableViewDataSource{
    
    // Core Data data store will be injected into the variable from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Data store will be injected into the variable from the app delegate
    var dataStore: DataStore!
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercisesPrototypeCell", for: indexPath)
        let exercise = dataStore.exercises[indexPath.row]
        let exerciseName = exercise.name
        let exerciseType = exercise.type
        
        cell.textLabel?.text = exerciseName
        cell.detailTextLabel?.text = exerciseType
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.idForSegueToExerciseDetails?: 
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the target view controller
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        print("unwind with changes")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
    }
    
    
}
