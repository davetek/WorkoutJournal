//
//  WorkoutsViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class WorkoutsViewController: UIViewController {
    
    //set up a data variable; an instance of DataStore
    // will be injected into the variable from the AppDelegate
    var workoutData: [[String: Any]]!
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
}
