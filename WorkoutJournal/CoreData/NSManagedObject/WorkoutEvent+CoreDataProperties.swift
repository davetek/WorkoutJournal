//
//  WorkoutEvent+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 12/2/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension WorkoutEvent {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<WorkoutEvent> {
        return NSFetchRequest<WorkoutEvent>(entityName: "WorkoutEvent")
    }

    @NSManaged public var workoutDate: NSDate?
    @NSManaged public var workout: Workout?

}
