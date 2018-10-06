//
//  WorkoutsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController, UITableViewDataSource {
    
    //set up a data variable; an instance of DataStore
    // will be injected into the variable from the AppDelegate
    var workoutData: [[String: Any]]!
    
    @IBOutlet var tableView: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workoutData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "workoutsPrototypeCell", for: indexPath)
        let workout = workoutData[indexPath.row]
        let workoutDate = workout["date"]
        let workoutType = workout["type"]
        cell.textLabel?.text = workoutType as! String
        cell.detailTextLabel?.text = workoutDate as! String
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
    }
}
