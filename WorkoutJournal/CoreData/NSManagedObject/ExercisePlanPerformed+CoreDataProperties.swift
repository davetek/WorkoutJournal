//
//  ExercisePlanPerformed+CoreDataProperties.swift
//  WorkoutJournal
//
//  Created by David Lawrence on 12/2/18.
//  Copyright © 2018 clarity for action. All rights reserved.
//
//

import Foundation
import CoreData


extension ExercisePlanPerformed {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExercisePlanPerformed> {
        return NSFetchRequest<ExercisePlanPerformed>(entityName: "ExercisePlanPerformed")
    }

    @NSManaged public var datePerformed: NSDate?
    @NSManaged public var exercisePlan: ExercisePlan?
    @NSManaged public var person: Person?

}
