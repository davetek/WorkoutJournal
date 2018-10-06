//
//  ExercisesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExercisesViewController: UIViewController, UITableViewDataSource{
    
    //set up a data variable; an instance of DataStore
    // will be injected into the variable from the AppDelegate
    var exerciseData: [String]!
    
    @IBOutlet var tableView: UITableView!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exercisesPrototypeCell", for: indexPath)
        let exerciseName = exerciseData[indexPath.row]
        
        cell.textLabel?.text = exerciseName
        return cell
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
    }
    
    
}
