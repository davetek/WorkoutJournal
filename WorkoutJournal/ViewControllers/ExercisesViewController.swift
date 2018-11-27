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
    
    // Data store will be injected into the variable from the app delegate
    var dataStore: DataStore!
    
    // Set up an array of dictionaries 2b used in fetchFromCoreData() method
    //  to represent Exercises records fetched from Core Data data store
    var exercisesInWorkoutJournalDataStore = [[String: String]]()
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        fetchFromCoreData()
    }
    
    
    //get records from Core Data data store
    func fetchFromCoreData()  {
        let context = workoutJournalDataStore.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
        request.returnsObjectsAsFaults = false
        
        //clear all items from the array that will hold the fetched records
        exercisesInWorkoutJournalDataStore.removeAll()
        
        do {
            let result = try context.fetch(request)
            for data in result as! [NSManagedObject] {
                print(data.value(forKey: "name") as! String)
                print(data.value(forKey: "type") as! String)
                let newRecord = ["name": data.value(forKey: "name") as! String,
                                 "type": data.value(forKey: "type") as! String]
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
        case Constants.idForSegueToExerciseDetails?:
            
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the target view controller
                let exerciseDetailsNavController = segue.destination as! UINavigationController
                let exerciseDetailsViewController = exerciseDetailsNavController.topViewController as! ExerciseDetailsViewController
                
                exerciseDetailsViewController.workoutJournalDataStore = workoutJournalDataStore
                
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }
    
    @IBAction func unwindToExercisesViewController(_ sender: UIStoryboardSegue) {}
    
    @IBAction func unwindWithChangesToExercisesViewController(_ sender: UIStoryboardSegue) {
        //exercise was added; reload tableview
        print("unwind with changes")
        fetchFromCoreData()
        tableView.reloadData()
    }
    
  
    
    
}
