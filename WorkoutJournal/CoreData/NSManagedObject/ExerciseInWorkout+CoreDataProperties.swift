//
//  ExerciseInWorkout+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/16/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseInWorkout {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseInWorkout> {
        return NSFetchRequest<ExerciseInWorkout>(entityName: "ExerciseInWorkout")
    }

    @NSManaged public var position: Int16
    @NSManaged public var exercise: Exercise?
    @NSManaged public var exerciseGoal: ExerciseGoal?
    @NSManaged public var workout: Workout?

}
