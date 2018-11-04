//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController, UITableViewDataSource{
    
    // Data store will be injected into the variable from the AppDelegate
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
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
    }
    
    
}
