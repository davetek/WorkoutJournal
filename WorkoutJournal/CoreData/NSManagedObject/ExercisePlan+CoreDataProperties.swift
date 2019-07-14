//
//  ExercisePlan+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 7/14/19.
//  Copyright © 2019 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExercisePlan {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExercisePlan> {
        return NSFetchRequest<ExercisePlan>(entityName: "ExercisePlan")
    }

    @NSManaged public var sets: Int16
    @NSManaged public var restBtwnSets: Int16
    @NSManaged public var repsPerSet: Int16
    @NSManaged public var setsPyramidTo: Int16
    @NSManaged public var setsPyramidDblPeakTo: Int16
    @NSManaged public var setsPyramidStepSize: Int16
    @NSManaged public var setTimeDuration: Int16
    @NSManaged public var setsTotalTime: Int16
    @NSManaged public var setDistance: Int16
    @NSManaged public var setsTotalDistance: Int16
    @NSManaged public var exercise: Exercise?

}
