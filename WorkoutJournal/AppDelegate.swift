//
//  AppDelegate.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 10/5/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //create an instance of the data store that uses Core Data
        let workoutJournalDataStore = WorkoutJournalDataStore()
        
        //create an instance of the data store
        let dataStore = DataStore()
                
        //get reference to the workouts view controller and inject data into it from the data store
        let workoutsNavController = window!.rootViewController?.children[0] as! UINavigationController
        let workoutsViewController = workoutsNavController.topViewController as! WorkoutsViewController
        workoutsViewController.dataStore = dataStore
        
        //get reference to the workouts view controller and inject data into it from the data store
        let exercisesNavController = window!.rootViewController?.children[1] as! UINavigationController
        let exercisesViewController = exercisesNavController.topViewController as! ExercisesViewController
        exercisesViewController.dataStore = dataStore
        
        //inject data into workouts view controller from the Core Data data store
        exercisesViewController.workoutJournalDataStore = workoutJournalDataStore

        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

   

}

