//
//  ExercisePlan+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/23/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExercisePlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExercisePlan> {
        return NSFetchRequest<ExercisePlan>(entityName: "ExercisePlan")
    }

    @NSManaged public var numSets: Int32
    @NSManaged public var minRepsPerSet: Int32
    @NSManaged public var maxRepsPerSet: Int32
    @NSManaged public var minTimePerRep: Double
    @NSManaged public var maxTimePerRep: Double
    @NSManaged public var setsRepsPyramidPeak: Int32
    @NSManaged public var setsRepsPyramidInterval: Int32
    @NSManaged public var minTimePerSet: Double
    @NSManaged public var maxTimePerSet: Double
    @NSManaged public var totalTime: Double
    @NSManaged public var totalDistance: Double
    @NSManaged public var exercise: Exercise
    @NSManaged public var exercisePlanPerformed: NSSet
    @NSManaged public var exercisePlanInRoutine: NSSet

}

// MARK: Generated accessors for exercisePlanPerformed
extension ExercisePlan {

    @objc(addExercisePlanPerformedObject:)
    @NSManaged public func addToExercisePlanPerformed(_ value: ExercisePlanPerformed)

    @objc(removeExercisePlanPerformedObject:)
    @NSManaged public func removeFromExercisePlanPerformed(_ value: ExercisePlanPerformed)

    @objc(addExercisePlanPerformed:)
    @NSManaged public func addToExercisePlanPerformed(_ values: NSSet)

    @objc(removeExercisePlanPerformed:)
    @NSManaged public func removeFromExercisePlanPerformed(_ values: NSSet)

}

// MARK: Generated accessors for exercisePlanInRoutine
extension ExercisePlan {

    @objc(addExercisePlanInRoutineObject:)
    @NSManaged public func addToExercisePlanInRoutine(_ value: ExercisePlanInRoutine)

    @objc(removeExercisePlanInRoutineObject:)
    @NSManaged public func removeFromExercisePlanInRoutine(_ value: ExercisePlanInRoutine)

    @objc(addExercisePlanInRoutine:)
    @NSManaged public func addToExercisePlanInRoutine(_ values: NSSet)

    @objc(removeExercisePlanInRoutine:)
    @NSManaged public func removeFromExercisePlanInRoutine(_ values: NSSet)

}
