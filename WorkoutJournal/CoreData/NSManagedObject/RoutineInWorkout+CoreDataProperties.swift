//
//  RoutineInWorkout+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/23/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension RoutineInWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RoutineInWorkout> {
        return NSFetchRequest<RoutineInWorkout>(entityName: "RoutineInWorkout")
    }

    @NSManaged public var positionInSequence: Int32
    @NSManaged public var workout: Workout
    @NSManaged public var routine: Routine

}
