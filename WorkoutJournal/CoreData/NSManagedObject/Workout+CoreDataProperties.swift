//
//  Workout+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/16/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension Workout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Workout> {
        return NSFetchRequest<Workout>(entityName: "Workout")
    }

    @NSManaged public var name: String?
    @NSManaged public var exerciseInWorkout: ExerciseInWorkout?

}
