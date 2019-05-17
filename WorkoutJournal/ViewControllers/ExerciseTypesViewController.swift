//
//  ExerciseTypesViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/6/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

class ExerciseTypesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, DataDependencyInjection  {
    
    
    
    let data = ["type1", "type2", "type3", "type4"]
    
    var viewModel: ExerciseTypesViewModel?
    
    func instantiateViewModelWithDataStore(_ dataStore: WorkoutJournalDataStore) {
        viewModel = ExerciseTypesViewModel(dataStore: dataStore)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseTypeCell", for: indexPath)
        
        let exerciseTypeName = data[indexPath.row]
        
        cell.textLabel?.text = exerciseTypeName
        
        return cell
    }
    
    

    
    

    
    
}
