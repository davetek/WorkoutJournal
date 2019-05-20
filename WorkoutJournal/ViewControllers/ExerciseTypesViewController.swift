//
//  ExerciseTypesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/6/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

class ExerciseTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDependencyInjection  {
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func addButton(_ sender: UIBarButtonItem) {
    }
    
    var viewModel: ExerciseTypesViewModel!
    
    
    func instantiateViewModelWithDataStore(_ dataStore: WorkoutJournalDataStore) {
        viewModel = ExerciseTypesViewModel(dataStore: dataStore)
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.exerciseTypesInDataStore.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseTypeCell", for: indexPath)
        
        let exerciseType = viewModel.exerciseTypesInDataStore[indexPath.row]
        let exerciseTypeName = exerciseType.name
        
        cell.textLabel?.text = exerciseTypeName
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
            
        //if add button was tapped
        case Constants.idForSequeToAddExerciseTypeDetails?:
            let exerciseTypeDetailsNavController = segue.destination as! UINavigationController
            let exerciseTypeDetailsViewController = exerciseTypeDetailsNavController.topViewController as! ExerciseTypeDetailsViewController
            
            let exerciseTypeDetailsViewModel = ExerciseTypeDetailsViewModel(dataStore: viewModel.workoutJournalDataStore )
            
            exerciseTypeDetailsViewController.exerciseTypeDetailsViewModel = exerciseTypeDetailsViewModel
            
            
        //if an exercise type was tapped
        case Constants.idForSegueToExerciseTypeDetails?:
            if let row = tableView.indexPathForSelectedRow?.row {
                //get the data for the tapped row and inject it into the exercise details view model
                let exerciseTypeDetailsNavController = segue.destination as! UINavigationController
                let exerciseTypeDetailsViewController = exerciseTypeDetailsNavController.topViewController as! ExerciseTypeDetailsViewController
                
                //create an ExerciseDetailsViewModel instance
                let exerciseTypeDetailsViewModel = ExerciseTypeDetailsViewModel(dataStore: viewModel.workoutJournalDataStore, exerciseTypeSelected: viewModel.exerciseTypesInDataStore[row])
                
                exerciseTypeDetailsViewController.exerciseTypeDetailsViewModel = exerciseTypeDetailsViewModel
            }
        default:
            preconditionFailure("segue identifier not found")
        }
    }

    
    

    
    

    
    
}
