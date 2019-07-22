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
        print("tab bar controller created")
        
        
        let childViewControllers: [UIViewController] = self.children
        //check if item [0] in array is a UINavigationController
        //if it is, get the root view controller of item [0]
        //then call the instantiateViewModelWithDataStore() method on that view controller
        if childViewControllers[0] is UINavigationController {
            print("first child is a UINavigationContoller")
            let initialViewController = childViewControllers[0].children[0] as? DataDependencyInjection
            initialViewController?.instantiateViewModelWithDataStore(workoutJournalDataStore)
        }
    }
    
    //Instantiate the appropriate view model with the data store. The 'viewController' parameter will be a
    // UINavigationController, with the target view controller in its children array
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        
        //check if the selected view controller is the initial view controller for the tab bar; if not,
        //instantiate the view model
        if viewController === self.children[0] {
            print("selected vc is root vc of tab bar")
        } else {
            if viewController is UINavigationController {
                let targetViewController = viewController.children[0] as? DataDependencyInjection
                targetViewController?.instantiateViewModelWithDataStore(workoutJournalDataStore)
                //print("instantiated view model from tab bar controller")
            }
        }
    }
    

    
}
