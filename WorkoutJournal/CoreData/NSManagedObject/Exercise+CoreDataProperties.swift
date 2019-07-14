//
//  Exercise+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/14/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise")
    }

    @NSManaged public var name: String?
    @NSManaged public var url: String?
    @NSManaged public var attribute: NSObject?
    @NSManaged public var attribute1: NSObject?
    @NSManaged public var exerciseTypes: ExerciseType?
    @NSManaged public var exercisePlan: NSSet?

}

// MARK: Generated accessors for exercisePlan
extension Exercise {

    @objc(addExercisePlanObject:)
    @NSManaged public func addToExercisePlan(_ value: ExercisePlan)

    @objc(removeExercisePlanObject:)
    @NSManaged public func removeFromExercisePlan(_ value: ExercisePlan)

    @objc(addExercisePlan:)
    @NSManaged public func addToExercisePlan(_ values: NSSet)

    @objc(removeExercisePlan:)
    @NSManaged public func removeFromExercisePlan(_ values: NSSet)

}
