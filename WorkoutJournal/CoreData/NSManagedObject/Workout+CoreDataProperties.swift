//
//  Workout+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/23/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var routineInWorkout: NSSet
    @NSManaged public var workoutEvent: NSSet

}

// MARK: Generated accessors for routineInWorkout
extension Workout {

    @objc(addRoutineInWorkoutObject:)
    @NSManaged public func addToRoutineInWorkout(_ value: RoutineInWorkout)

    @objc(removeRoutineInWorkoutObject:)
    @NSManaged public func removeFromRoutineInWorkout(_ value: RoutineInWorkout)

    @objc(addRoutineInWorkout:)
    @NSManaged public func addToRoutineInWorkout(_ values: NSSet)

    @objc(removeRoutineInWorkout:)
    @NSManaged public func removeFromRoutineInWorkout(_ values: NSSet)

}

// MARK: Generated accessors for workoutEvent
extension Workout {

    @objc(addWorkoutEventObject:)
    @NSManaged public func addToWorkoutEvent(_ value: WorkoutEvent)

    @objc(removeWorkoutEventObject:)
    @NSManaged public func removeFromWorkoutEvent(_ value: WorkoutEvent)

    @objc(addWorkoutEvent:)
    @NSManaged public func addToWorkoutEvent(_ values: NSSet)

    @objc(removeWorkoutEvent:)
    @NSManaged public func removeFromWorkoutEvent(_ values: NSSet)

}
