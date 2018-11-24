//
//  ExercisePlanInRoutine+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 11/23/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExercisePlanInRoutine {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExercisePlanInRoutine> {
        return NSFetchRequest<ExercisePlanInRoutine>(entityName: "ExercisePlanInRoutine")
    }

    @NSManaged public var positionInSequence: Int32
    @NSManaged public var routine: Routine
    @NSManaged public var exercisePlan: ExercisePlan

}
