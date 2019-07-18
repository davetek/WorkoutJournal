//
//  ExerciseType+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/17/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseType> {
        return NSFetchRequest<ExerciseType>(entityName: "ExerciseType")
    }

    @NSManaged public var name: String?
    @NSManaged public var exercises: NSSet?

}

// MARK: Generated accessors for exercises
extension ExerciseType {

    @objc(addExercisesObject:)
    @NSManaged public func addToExercises(_ value: Exercise)

    @objc(removeExercisesObject:)
    @NSManaged public func removeFromExercises(_ value: Exercise)

    @objc(addExercises:)
    @NSManaged public func addToExercises(_ values: NSSet)

    @objc(removeExercises:)
    @NSManaged public func removeFromExercises(_ values: NSSet)

}
