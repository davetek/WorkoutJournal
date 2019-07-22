//
//  WorkoutsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/14/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDependencyInjection {
    
    var viewModel: WorkoutsViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    func instantiateViewModelWithDataStore(_ dataStore: WorkoutJournalDataStore) {
        viewModel = WorkoutsViewModel(dataStore: dataStore)
        print("WorkoutsViewModel instantiated with data store")
    }
    
    
    @IBAction func toggleEditingMode(_ sender: UIBarButtonItem) {
        //if in editing mode
        if self.tableView.isEditing {
            
            //change the button title
            if sender.title != nil {
                sender.title = "Edit"
            }
            
            //turn off editing mode
            self.tableView.isEditing = false
            
        } else {
            //change the button title
            if sender.title != nil {
                sender.title = "Done"
            }
            
            //enter editing mode
            self.tableView.isEditing = true
        }
    }
    
    @IBAction func addWorkout(_ sender: UIBarButtonItem) {
        //triggers actions
    }
    
    func wasAppAlreadyLaunchedOnce() -> Bool {
        let defaults = UserDefaults.standard
        if let _ = defaults.string(forKey: "isAppAlreadyLaunchedOnce"){
            print("App already launched")
            return true
        } else {
            defaults.set(true, forKey: "isAppAlreadyLaunchedOnce")
            print("App launched first time")
            return false
        }
    }
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 60
        
        let appWasLaunchedBefore: Bool = wasAppAlreadyLaunchedOnce()
        if appWasLaunchedBefore == false {
            viewModel.workoutJournalDataStore.addDefaultData()
        }
        viewModel.fetchWorkouts()
        print(viewModel.workoutsInDataStore.count)
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.workoutsInDataStore.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutCell", for: indexPath)
        
        let workout = viewModel.workoutsInDataStore[indexPath.row]
        let workoutName = workout.name
        
        cell.textLabel?.text = workoutName
        
        return cell
        
        
    }
    
    
}
