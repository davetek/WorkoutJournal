//
//  ExerciseGoal+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/17/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExerciseGoal {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExerciseGoal> {
        return NSFetchRequest<ExerciseGoal>(entityName: "ExerciseGoal")
    }

    @NSManaged public var exerciseInWorkout: ExerciseInWorkout?
    @NSManaged public var exercisePlan: ExercisePlan?

}