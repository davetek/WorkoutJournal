//
//  Routine+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/23/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Routine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Routine> {
        return NSFetchRequest<Routine>(entityName: "Routine")
    }

    @NSManaged public var name: String?
    @NSManaged public var pattern: String
    @NSManaged public var repetitions: Int32
    @NSManaged public var timePerRepetition: Double
    @NSManaged public var totalDistance: Double
    @NSManaged public var totalTime: Double
    @NSManaged public var exercisePlanInRoutine: NSSet
    @NSManaged public var routineInWorkout: NSSet

}

// MARK: Generated accessors for exercisePlanInRoutine
extension Routine {

    @objc(addExercisePlanInRoutineObject:)
    @NSManaged public func addToExercisePlanInRoutine(_ value: ExercisePlanInRoutine)

    @objc(removeExercisePlanInRoutineObject:)
    @NSManaged public func removeFromExercisePlanInRoutine(_ value: ExercisePlanInRoutine)

    @objc(addExercisePlanInRoutine:)
    @NSManaged public func addToExercisePlanInRoutine(_ values: NSSet)

    @objc(removeExercisePlanInRoutine:)
    @NSManaged public func removeFromExercisePlanInRoutine(_ values: NSSet)

}

// MARK: Generated accessors for routineInWorkout
extension Routine {

    @objc(addRoutineInWorkoutObject:)
    @NSManaged public func addToRoutineInWorkout(_ value: RoutineInWorkout)

    @objc(removeRoutineInWorkoutObject:)
    @NSManaged public func removeFromRoutineInWorkout(_ value: RoutineInWorkout)

    @objc(addRoutineInWorkout:)
    @NSManaged public func addToRoutineInWorkout(_ values: NSSet)

    @objc(removeRoutineInWorkout:)
    @NSManaged public func removeFromRoutineInWorkout(_ values: NSSet)

}
