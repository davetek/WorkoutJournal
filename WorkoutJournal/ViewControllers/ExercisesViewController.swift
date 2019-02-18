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
    
    // Core Data data store will be injected into the variable from the app delegate
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    // Set up an array of dictionaries 2b used in fetchFromCoreData() method
    //  to represent Exercises records fetched from Core Data data store
    var exercisesInWorkoutJournalDataStore = [[String: String]]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: Any) {
    }
    
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        fetchFromCoreData()
    }
    
    
    //get records from Core Data data store
    func fetchFromCoreData()  {
        let context = workoutJournalDataStore.persistentContainer.viewContext
        
        //Liam 2019-02-10 could set as <Exercise> result
        let request = NSFetchRequest<Exercise>(entityName: "Exercise")
        request.returnsObjectsAsFaults = false
        
        //clear all items from the array that will hold the fetched records
        exercisesInWorkoutJournalDataStore.removeAll()
        
        do {
            let result = try context.fetch(request)
            // just removed cast to array of [NSManagedObject]
            for data in result {
                // need to cast data as Exercise
                // and then can access attributes as properties
                
                //print(data.value(forKey: "name") as! String)
                //print(data.value(forKey: "type") as! String)
                let newRecord = ["name": data.value(forKey: "name") as! String,
                                 "type": data.value(forKey: "type") as! String,
                                 "url": data.value(forKey: "url") as! String]
                exercisesInWorkoutJournalDataStore.append(newRecord)
            }
        } catch {
            print("fetch from Core Data failed")
        }
        
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return dataStore.exercises.count
        return exercisesInWorkoutJournalDataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercisesPrototypeCell", for: indexPath)
//        let exercise = dataStore.exercises[indexPath.row]
//        let exerciseName = exercise.name
//        let exerciseType = exercise.type
        
        let exercise = exercisesInWorkoutJournalDataStore[indexPath.row]
        let exerciseName = exercise["name"]
        let exerciseType = exercise["type"]
        
        cell.textLabel?.text = exerciseName
        cell.detailTextLabel?.text = exerciseType
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case Constants.idForSegueToAddExerciseDetails?:
            let exerciseDetailsNavController = segue.destination as! UINavigationController
            let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
            exerciseDetailsViewController.workoutJournalDataStore = workoutJournalDataStore
            
        case Constants.idForSegueToExerciseDetails?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the target view controller
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                exerciseDetailsViewController.workoutJournalDataStore = workoutJournalDataStore
                
                let exerciseSelected: [String: String] = exercisesInWorkoutJournalDataStore[row]
                exerciseDetailsViewController.exercise = exerciseSelected
                
                
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        //print("unwind with changes")
        fetchFromCoreData()
        tableView.reloadData()
    }
    
  
    
    
}
