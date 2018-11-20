//
//  Person+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/19/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var displayName: String?
    @NSManaged public var exercisePlanPerformed: NSSet?

}

// MARK: Generated accessors for exercisePlanPerformed
extension Person {

    @objc(addExercisePlanPerformedObject:)
    @NSManaged public func addToExercisePlanPerformed(_ value: ExercisePlanPerformed)

    @objc(removeExercisePlanPerformedObject:)
    @NSManaged public func removeFromExercisePlanPerformed(_ value: ExercisePlanPerformed)

    @objc(addExercisePlanPerformed:)
    @NSManaged public func addToExercisePlanPerformed(_ values: NSSet)

    @objc(removeExercisePlanPerformed:)
    @NSManaged public func removeFromExercisePlanPerformed(_ values: NSSet)

}
