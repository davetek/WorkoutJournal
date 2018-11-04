//
//  WorkoutsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController, UITableViewDataSource {
    
    //data store will be injected by AppDelegate
    var dataStore: DataStore!
    
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func cancelToWorkoutsViewController(_ segue: UIStoryboardSegue) {
    }
    
    @IBAction func saveWorkoutDetails(_ segue: UIStoryboardSegue) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idForWorkoutsPrototypeCell, for: indexPath)
        let workout = dataStore.workouts[indexPath.row]
        let workoutDate = workout.startDate
        let workoutId = String(workout.id)

        cell.textLabel?.text = "\(workoutId) Section: \(indexPath.section) Row: \(indexPath.row)"
        cell.detailTextLabel?.text = workoutDate
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.idForSegueToWorkoutDetail?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the workout data for the tapped row, and inject it into the target view controller
                let workoutDetailsNavController = segue.destination as! UINavigationController
                let workoutDetailsViewController = workoutDetailsNavController.topViewController as! WorkoutDetailsViewController
                workoutDetailsViewController.dataStore = dataStore
                workoutDetailsViewController.workoutsListRowNumber = row
            }
        default:
            preconditionFailure("segue identifier not found")
        }
        
        
    }
}
