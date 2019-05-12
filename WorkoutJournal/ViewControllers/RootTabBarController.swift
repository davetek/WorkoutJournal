//
//  RootTabBarController.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 5/11/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // Core Data data store will be injected into the variable from the app delegate
    // this departs from MVVM, but allows the data to be injected from the root view
    // down to each tab hierarchy
    var workoutJournalDataStore: WorkoutJournalDataStore!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {

        let selectedViewController = viewController
        let selectedViewControllerTypeValue = type(of: selectedViewController)
        var actualViewControllerTypeValue: UIViewController.Type
        
        if selectedViewControllerTypeValue == UINavigationController.self {
            print("A nav controller was selected")
            let actualViewController = selectedViewController.children[0]
            actualViewControllerTypeValue = type(of: actualViewController)
            print("Child 0 of nav controller is a: \(actualViewControllerTypeValue)")
        } else {
            actualViewControllerTypeValue = selectedViewControllerTypeValue
        }
        
        
    }
    

    
}
