//
//  WorkoutDetailsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class WorkoutDetailsViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet var dateField: UITextField!
    @IBOutlet var numberField: UITextField!
    @IBOutlet var typeField: UITextField!
    @IBOutlet var performedField: UITextField!
    
    @IBOutlet var tableView: UITableView!
    
    //data injected from parent view controller when segue performed
    var dataStore: DataStore!
    var workoutsListRowNumber: Int!
    
    func numberOfSections(in tableView: UITableView) -> Int {
        let workoutSelected = dataStore.workouts[workoutsListRowNumber]
        return workoutSelected.routines.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //get the routine corresponding to the current section
        let workoutSelected = dataStore.workouts[workoutsListRowNumber]
        let routineIdForSection = workoutSelected.routines[section]
        
        let routine = dataStore.routines.filter({$0.id == routineIdForSection})[0]

        return "Section \(section): Routine \(routineIdForSection), type: \(routine.pattern) "
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //get the routine corresponding to the current section
        let workoutSelected = dataStore.workouts[workoutsListRowNumber]
        let routineIdForSection = workoutSelected.routines[section]
        
        //user filter and map to find the routine with id matching the id obtained from the workout
        let targetRoutine = dataStore.routines.filter({$0.id == routineIdForSection}).map({ return $0})[0]
        return targetRoutine.exercisePlans.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.idForWorkoutExercisesPrototypeCell, for: indexPath)
        
        let workoutSelected = dataStore.workouts[workoutsListRowNumber]

        //from the routines array in the workout, get the id of the routine corresponding to the section number
        let routineIdForSection = workoutSelected.routines[indexPath.section]
        
        //user filter and map to find the routine with id matching the id obtained from the workout
        let targetRoutine = dataStore.routines.filter({$0.id == routineIdForSection}).map({ return $0})[0]
        
        //get the exercise plan IDs in routine
        let exercisePlanIdsInRoutine = targetRoutine.exercisePlans
        
        //from the exercise plans in the data store, get the specific exercise plan corresponding to the table row
        let exercisePlan = dataStore.exercisePlans.filter({exercisePlanIdsInRoutine.contains($0.id)}).map({return $0})[indexPath.row]
        
        //get the exercise IDs in
        //get the exercises in the data store, get the exercise with the id matching that of the current exercise plan
        let exercise = dataStore.exercises.filter({$0.id == exercisePlan.exercise})[0]
        
        cell.textLabel?.text = "Exercise ID: \(exercise.id) - \(exercise.name)"
        cell.detailTextLabel?.text = "Exercise Plan ID: \(String(exercisePlan.id))"
        return cell
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
    }
    
    
    
}
