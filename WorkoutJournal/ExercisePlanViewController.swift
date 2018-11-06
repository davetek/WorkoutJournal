//
//  ExercisePlanViewController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit

class ExercisePlanViewController: UIViewController {
    
    @IBOutlet var idField: UITextField!
    @IBOutlet var exerciseField: UITextField!
    
    @IBOutlet var setsMinField: UITextField!
    @IBOutlet var setsMaxField: UITextField!
    @IBOutlet var repsMinField: UITextField!
    @IBOutlet var repsMaxField: UITextField!
    
    @IBOutlet var pyramidToField: UITextField!
    @IBOutlet var pyramidIntervalField: UITextField!
    
    @IBOutlet var timeField: UITextField!
    
    @IBOutlet var distanceField: UITextField!
    
    @IBOutlet var performedField: UITextField!
    
    override func viewDidLoad() {
        super .viewDidLoad()
    }
}
